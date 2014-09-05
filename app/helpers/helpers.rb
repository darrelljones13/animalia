helpers do
  def hierarchy
    @phylum = Phylum.all

    @phylum.each do |phylum|
      @class = Chlass.where(phylum_id: phylum.id)

        @chlass.each do |chlass|
          @order = Order.where(chlass_id: chlass.id)

            @order.each do |order|
              @family = Family.where(order_id: order.id)

                @family.each do |family|
                  @genus = Genus.where(family_id: family.id)

                    @genus.each do |genus|
                      @species = Species.where(genus_id: genus.id)
                    end
                end
            end
        end
    end
  end

end