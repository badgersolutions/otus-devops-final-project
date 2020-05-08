printjson(
rs.initiate(
    {
        _id : "mongo_cluster1",
        members: [
            { _id : 1, host : "10.0.1.26:27017" },
            { _id : 2, host : "10.0.1.27:27017" }
        ]
    }
)
)
