use("myDB");

//2.
db.authors.insertOne({FirstName: "Selma", LastName: "Lagerlöf"});

//3.
db.authors.insertOne({FirstName: "August", LastName: "Bondesson", Birth: 1854});

//4.
db.authors.updateOne
(
    {FirstName: "August", LastName: "Bondesson"}, 
    { $set: {death: 1906}}
);

//4,5
db.authors.updateOne
(
    {death: 1906}, 
    { $set: {Death: 1906}}
);
db.authors.updateOne
(
    {death: 1906}, 
    { $unset: {death: 1906}}
);

//5.
db.authors.countDocuments();

//6.

//7.
db.authors.countDocuments({FirstName: "August"});

//8.
db.authors.updateOne
(
    {FirstName: "Selma", LastName: "Lagerlöf"},
    {$set: {Birth: 1858, Death: 1940}}
)

//9.
db.authors.updateOne
(
    {FirstName: "Selma", LastName: "Lagerlöf"},
    {$set: {Books: ["Gösta Berlings saga", "En herrgårdssägen", "Nils Holgerssons underbara resa genom Sverige"]}}
)

//10.
db.authors.updateOne
(
    {FirstName: "Astrid", LastName: "Lindgren"},
    {$push: {Books: "Vi på Saltkråkan"}}
)

//11
db.authors.updateOne
(
    {FirstName: "Astrid", LastName: "Lindgren"},
    {$pull: {Books: "Bröderna Lejonhjärta"}}
)

//12.
db.authors.find({Death: {$gte: 2000} })

//13.
db.authors.countDocuments({Death: {$gte: 1940, $lt: 1950}});

//14.
db.authors.find(
    {
        Death: {$gte: 1940, $lt: 1950}
    },
    {
        _id: false,
        FirstName: true,
        LastName: true,
        Death: true
    }
);

//15.
db.authors.updateMany
(
    {FirstName: "Hjalmar"},
    {$set: {Gender: "Male"}}
);

//16.
db.authors.updateMany
(
    {FirstName: {$in: ["Astrid", "Karin", "Selma"]}},
    {$set: {Gender: "Female"}}
);

//17.
db.authors.updateOne
(
    {FirstName: "August", LastName: "Strindberg"},
    {$unset: {Books: ""}}
)

//18.
db.authors.deleteMany({FirstName: "August"});