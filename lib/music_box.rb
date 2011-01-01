require "ruby-sdl-ffi"

class MusicBox

  MUSIC_PATH = '../media/music/'
  MUSIC_EXT = '.ogg'

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

      path = sanitize_path path

      # Load
      music = SDL::Mixer::LoadMUS( path )
      if music.to_ptr.null?
        puts "ERROR: Could not load music: #{SDL::GetError()}"
        return nil
      end

      # Play
      if SDL::Mixer::PlayMusic( music.to_ptr, -1 ) == -1
        puts "ERROR: Could not play music: #{SDL::GetError()}"
        return nil                                                                                                                                                 end

      return music
    end

    def sanitize_path(path)
      if not path.include?('/') then
        path = MUSIC_PATH + path
      end

      if not path.end_with? MUSIC_EXT then
        path = path + MUSIC_EXT
      end

      path
    end

  end

end
