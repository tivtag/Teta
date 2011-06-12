require 'ruby-sdl-ffi/mixer'

class MusicBox

  MUSIC_PATH = '../media/music/'
  MUSIC_EXTS = ['.ogg', '.mp3']

  FADE_OUT_TIME = 2  
  FADE_IN_TIME = 4

  @@current = nil
  @@current_name = nil

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
  
    def play(name)
      if not @@initialized or name.nil? or name == @@current_name then
        return nil
      end

      Thread.new() do
        begin
          @@current = play_music (load_music (sanitize name))
          @@current_name = name
        rescue Exception => e
          puts "Music Error - #{e}"
        end
      end
    end

    def sanitize(path)
      unless path.include?('/')
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

  private
    def load_music(path)
      music = SDL::Mixer::LoadMUS(path)
      if music.to_ptr.null?
        raise "Load failed - #{SDL::GetError()}"
      end
      music
    end

    def fade_out
      if @@current != nil then
        SDL::Mixer::FadeOutMusic( FADE_OUT_TIME * 1000 )
        sleep FADE_OUT_TIME 
        @@current = nil
      end
    end

    def play_music(music)
      fade_out

      if SDL::Mixer::FadeInMusic( music.to_ptr, -1, FADE_IN_TIME * 1000 ) == -1
        raise "Play failed - #{SDL::GetError()}"
      end
      music
    end

  end

end
