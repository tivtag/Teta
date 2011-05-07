require 'ruby-sdl-ffi/mixer'

class MusicBox

  MUSIC_PATH = '../media/music/'
  MUSIC_EXTS = ['.ogg', '.mp3']

  FADE_OUT_TIME = 2  
  FADE_IN_TIME = 4

  @@current = nil
  @@current_path = nil

  class << self

    def init
      if( SDL::Mixer::OpenAudio( 22050, SDL::AUDIO_S16SYS, 2, 1024 ) == -1 )
        puts "ERROR: Could not initialize audio: #{SDL::GetError()}"
        return
      end

      # Make sure audio device closes at exit.
      at_exit { SDL::Mixer::CloseAudio() }
      @@initialized = true
    end
  
    def play(path)
      if not @@initialized or path.nil? then
        return nil
      end

      if path == @@current_path then
        return
      end

      Thread.new() do
        # Load
        real_path = sanitize_path path

        music = SDL::Mixer::LoadMUS( real_path )
        if music.to_ptr.null?
          puts "ERROR: Could not load music: #{SDL::GetError()}"
          return nil
        end

        # Fade Out
        if @@current != nil then
          SDL::Mixer::FadeOutMusic( FADE_OUT_TIME * 1000 )
          sleep FADE_OUT_TIME 
          @@current = nil
        end

        # Play
        if SDL::Mixer::FadeInMusic( music.to_ptr, -1, FADE_IN_TIME * 1000 ) == -1
          puts "ERROR: Could not play music: #{SDL::GetError()}"
          return nil
        end

        @@current = music
        @@current_path = path
      end
    
    end

    def sanitize_path(path)
      if not path.include?('/') then
        path = MUSIC_PATH + path
      end
        
      full_path = path

      MUSIC_EXTS.each do |ext|
         full_path = path + ext

         if File.exists? full_path then
            break 
         end 
      end

      full_path
    end

  end

end
