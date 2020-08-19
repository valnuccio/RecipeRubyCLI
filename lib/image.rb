class Image
    attr_accessor :image
    def initialize(url)
        @image = File.write 'image.png', open(url).read
        self.print
    end

    def print
        Catpix::print_image './image.png',
            :limit_x => 0.45,
            :limit_y => 0.45,
            :center_x => true,
            :resolution => "high"
    end
end