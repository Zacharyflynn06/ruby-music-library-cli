require 'pry'

class Song

    @@all = []

    attr_accessor :name
    attr_reader :artist, :genre

    def initialize(name, artist= nil, genre= nil)
        @name = name
        self.artist = (artist) if artist != nil
        self.genre = (genre) if genre != nil
        save
    end
    
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def save
       @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        Song.new(name)
    end

    def self.find_by_name(name)
        self.all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(file)
        song_name = file.split(" - ")[1]
        artist_name = file.split(" - ")[0]
        genre_name = file.split(" - ")[2].chomp(".mp3")
        song = Song.find_or_create_by_name(song_name)
        song.artist = Artist.find_or_create_by_name(artist_name)
        song.genre = Genre.find_or_create_by_name(genre_name)
        song
    end

    def self.create_from_filename(file)
        @@all << self.new_from_filename(file)
    end

end
