module App exposing (view, update, main)

import Html
import Html.Events as He
import Browser exposing (element)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button

import User exposing (..)


type alias Model = 
    { value: Int
    , numberOfClicks: Int
    , users: List User
    }
type Msg = Initialize | Increment | Decrement | Reset | Duplicate
            | DeleteUser User
-- Kako bolje naredit tole
--             | EditUserMsg Edit
-- type EditUser = Delete User | IncrPoints User | DecrPoints User

initialModel : () -> (Model, Cmd Msg)
initialModel () = ({value = 0, numberOfClicks = 0, users = initialUsers}, Cmd.none)

view : Model -> Html.Html Msg
view model =
    Grid.container [] (
    [ Html.h1 [] [Html.text "Hello world"]
    , Html.h2 [] [Html.text (String.fromInt model.value)]
    , Html.h2 [] [Html.text (String.fromInt model.numberOfClicks)]
    , Button.button 
        [ Button.success
        , Button.onClick Increment]
        [Html.text "Increment"]
    , Button.button
        [ Button.warning
        , Button.onClick Decrement]
        [Html.text "Decrement"]
    , Button.button
        [Button.onClick Duplicate]
        [Html.text "Duplicate"]
    , Button.button
        [Button.danger, Button.onClick Reset]
        [Html.text "Reset"]

    , Grid.row []
        [ Grid.col [] [Html.text "UID"]
        , Grid.col [] [Html.text "Ime"]
        , Grid.col [] [Html.text "Točke"]
        ]
    ] ++ (
        model.users
        |> List.sortBy .points
        |> List.reverse
        |> List.map (\usr -> Grid.row []
                                [ Grid.col [] [Html.text (String.fromInt usr.uid)]
                                , Grid.col [] [Html.text usr.name]
                                , Grid.col [] [Html.text (String.fromInt usr.points)]
                                , Grid.col [] [Button.button [Button.onClick (DeleteUser usr)] [Html.text "X"]]
                                ])
    )
    )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment -> ({model | value = model.value + 1,
                       numberOfClicks = model.numberOfClicks + 1}, Cmd.none)
        Decrement -> ({model | value = model.value - 1,
                       numberOfClicks = model.numberOfClicks + 1}, Cmd.none)
        Duplicate -> ({model | value = model.value * 2,
                       numberOfClicks = model.numberOfClicks + 1}, Cmd.none)
        Reset -> initialModel ()
        DeleteUser usr -> ({model | users = List.filter (\user -> usr.uid /= user.uid) model.users}, Cmd.none)
        _ -> (model, Cmd.none)

main : Program () Model Msg
main =
    element
        { init = initialModel
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }