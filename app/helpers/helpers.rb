helpers do


  def hierarchy
    @phylum = Phylum.all
    # @kingdom = Hash[@phylum => @phylum.name]
    tree = {children: @phylum.map {|phylum| {name: phylum.name,
        children: Chlass.where(phylum_id: phylum.id).map {|chlass| {name: chlass.name,
            children: Order.where(chlass_id: chlass.id).map {|order| {name: order.name,
                children: Family.where(order_id: order.id).map {|family| {name: family.name,
                    children: Genus.where(family_id: family.id).map { |genus| {name: genus.name}}}}}}}}}}}
         
    p tree
  end

  
end




