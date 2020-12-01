class Artist

    extend Concerns::Findable
    
    @@all = []

    attr_accessor :name, :songs

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def songs
        @songs
    end

    def genres
        @songs.collect {|song| song.genre}.uniq
    end

    def save
       @@all << self
    end

    def add_song(song)
        @songs << song unless @songs.include?(song)
        song.artist = self if !song.artist
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        Artist.new(name)
    end


end