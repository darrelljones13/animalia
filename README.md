# TreeFrog

![Travis Status](https://travis-ci.org/darrelljones13/animalia.svg?branch=master)


## Purpose

TreeFrog is an educational and exploratory tool that portrays the vastness of the animal kingdom and visually traverses the relationships between animals through their taxonomy.  Users can interactively explore the various connections between members of the animal kingdom via dynamic data visualization. By providing data about each creature's environment, characteristics, and endangerment status, TreeFrog aims to inspire respect for the rich variety of the natural world.


## Getting Started

The animal kingdom is categorized in a tree structure, where each "branch" contains its own subcategories; starting at the kingdom level, classification becomes more specific as we move further from the "trunk," through phylum, class, order, family, genus, and finally individual animal species.

Begin by clicking "Create New Account" in the page header and signing up. With a user account, you'll be able to keep track of the animals you discover by adding them to collections.

This build of TreeFrog contains only species within the phylum *chordata*, which consists of vertebrates. To start exploring, simply click an icon in the Class column to select between birds, mammals, reptiles, amphibians, and fish. Then select an order from the options that appear, and keep selecting narrower classifications until you arrive at a species. Check out the animal's photo and description, and click "Add to Collection!" to save the species. You can create multiple collections to keep your favorite animals organized.


## Contributions

There are over 1.5 million known species on Earth, and TreeFrog is just scratiching the surface! We gathered our species information by scraping taxonomy sites like ITIS and GBIF (see "Resources" below) into CSV files, and then using those files to populate database tables. If you would like to help us expand beyond *chordata*, please feel free to fork this repository and add to it. Pull requests are always welcome.


## License

TreeFrog was initially created in eight days at Dev Bootcamp Chicago, by Darrell Jones, Jeff Keslin, Jennie Chamberlin, Ryan Spencer, and Duke Greene. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.  


## Resources

[Integrated Taxonomic Integration System](http://www.itis.gov/)  
[Global Biodiversity Information Facility](http://www.gbif.org/)  
[Encyclopedia of Life](http://eol.org/)


