module User exposing (..)

type alias User = 
    { uid: Int
    , name: String
    , points: Int
    }

initialUsers =
    [ {uid=1, name="Ana", points=12}
    , {uid=2, name="Berta", points=17}
    , {uid=3, name="Cilka", points=-2}
    ]