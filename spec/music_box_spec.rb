require_relative '../lib/music_box'

describe MusicBox do

  # ToDo: Fake out file checking
  describe 'when sanitizing a path' do

    context 'that specifies no relative folder' do
      let(:path) { 'rain' }
      
      it 'adds the default music path to the path' do
        new_path = MusicBox.sanitize path
        new_path.should == MusicBox::MUSIC_PATH + path + MusicBox::MUSIC_EXTS.last
      end
    end

    context 'that specifies no file extension and does not exist with any extension' do
      let(:path) { 'path/to/file' }

      it 'adds the last file extension to the end of the path' do
        new_path = MusicBox.sanitize path
        new_path.should == path + MusicBox::MUSIC_EXTS.last
      end
    end

    context 'that specifies no relative folder and no file extension' do
      let(:path) { 'file' }

      it 'adds the relative music path and default file extension to the path' do
        new_path = MusicBox.sanitize path
        new_path.should == MusicBox::MUSIC_PATH + path + MusicBox::MUSIC_EXTS.last
      end
    end
  end

end

