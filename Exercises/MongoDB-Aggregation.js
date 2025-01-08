//1.
use ("sample_airbnb");

db.listingsAndReviews.aggregate(
[
    {$match: 
        {
            property_type:"House",
            amenities: {$all: ["Pool", "Air conditioning", "BBQ grill", "Gym"]}
        }
    },
    {$project: 
        {
            _id: false,
            name: true,
            price: true,
            listing_url: true
        }
    }
]);

//Alternativ utan aggregering.
db.listingsAndReviews.find(
            {
                property_type:"House",
                amenities: {$all: ["Pool", "Air conditioning", "BBQ grill", "Gym"]}
            },
            {
                _id: false,
                name: true,
                price: true,
                listing_url: true
            });

//2.
use ("sample_mflix");

db.movies.aggregate(
[
    {$match: 
        {
            cast: {$all: ["Adam Sandler", "Drew Barrymore"] } 
        }
    },
    {   
        $count: "numberOfMovies"
    }
]);

//Alternativ utan aggregering.
db.movies.countDocuments({cast: {$all: ["Adam Sandler", "Drew Barrymore"]}});

//3.
db.movies.aggregate(
[
    {$group: 
        {
            _id: "$rated",
            numberOfMovies: {$count: {}}
        }
    },
    {$match:
        {
            _id: {$ne: null}
        }
    },
    {$sort: 
        {numberOfMovies: -1}
    }
])

//4.
db.movies.aggregate(
[
    {$match: 
        {
            cast: "Harrison Ford"
        }
    },
    {$group: 
        {
            _id: null,
            numberOfMovies: {$sum: 1},
            lowestRating: {$min: "$imdb.rating"},
            highestRating: {$max: "$imdb.rating"},
            averageRating: {$avg: "$imdb.rating"},
        }
    },
    {$project:
        {
            _id: false,
            numberOfMovies: true,
            lowestRating: true,
            highestRating: true,
            averageRating: {$round: ["$averageRating", 2]}
        }
    }
]);

//5.
use ("sample_supplies");

db.createView("satisfaction", "sales",
    [
        {$group: 
            {
                _id: { gender: "$customer.gender", purchaseMethod: "$purchaseMethod" },
                avgSatisfaction: {$avg: "$customer.satisfaction"}
            }
        },
        {$project: 
            {
                _id: {$concat: ["$_id.gender", " (", "$_id.purchaseMethod", ")"]},
                avgSatisfaction: { $round: ["$avgSatisfaction", 2]} 
            }
        }
    ]
);

