module Exts.Html.Bootstrap.Glyphicons exposing (glyphicon, Glyphicon(..))

{-| Type-safe glyphicons for Twitter Bootstrap 3 users.

@docs glyphicon
@docs Glyphicon
-}

import Html exposing (..)
import Html.Attributes exposing (..)


{-| A type-safe list of all available glyphicons in Bootstrap. To fit
Elm's syntax we convert from kebab-case to CamelCase, so
`"glyphicon-star-empty"` becomes the type constructor `StarEmpty`.
-}
type Glyphicon
    = Asterisk
    | Plus
    | Euro
    | Eur
    | Minus
    | Cloud
    | Envelope
    | Pencil
    | Glass
    | Music
    | Search
    | Heart
    | Star
    | StarEmpty
    | User
    | Film
    | ThLarge
    | Th
    | ThList
    | Ok
    | Remove
    | ZoomIn
    | ZoomOut
    | Off
    | Signal
    | Cog
    | Trash
    | Home
    | File
    | Time
    | Road
    | DownloadAlt
    | Download
    | Upload
    | Inbox
    | PlayCircle
    | Repeat
    | Refresh
    | ListAlt
    | Lock
    | Flag
    | Headphones
    | VolumeOff
    | VolumeDown
    | VolumeUp
    | Qrcode
    | Barcode
    | Tag
    | Tags
    | Book
    | Bookmark
    | Print
    | Camera
    | Font
    | Bold
    | Italic
    | TextHeight
    | TextWidth
    | AlignLeft
    | AlignCenter
    | AlignRight
    | AlignJustify
    | List
    | IndentLeft
    | IndentRight
    | FacetimeVideo
    | Picture
    | MapMarker
    | Adjust
    | Tint
    | Edit
    | Share
    | Check
    | Move
    | StepBackward
    | FastBackward
    | Backward
    | Play
    | Pause
    | Stop
    | Forward
    | FastForward
    | StepForward
    | Eject
    | ChevronLeft
    | ChevronRight
    | PlusSign
    | MinusSign
    | RemoveSign
    | OkSign
    | QuestionSign
    | InfoSign
    | Screenshot
    | RemoveCircle
    | OkCircle
    | BanCircle
    | ArrowLeft
    | ArrowRight
    | ArrowUp
    | ArrowDown
    | ShareAlt
    | ResizeFull
    | ResizeSmall
    | ExclamationSign
    | Gift
    | Leaf
    | Fire
    | EyeOpen
    | EyeClose
    | WarningSign
    | Plane
    | Calendar
    | Random
    | Comment
    | Magnet
    | ChevronUp
    | ChevronDown
    | Retweet
    | ShoppingCart
    | FolderClose
    | FolderOpen
    | ResizeVertical
    | ResizeHorizontal
    | Hdd
    | Bullhorn
    | Bell
    | Certificate
    | ThumbsUp
    | ThumbsDown
    | HandRight
    | HandLeft
    | HandUp
    | HandDown
    | CircleArrowRight
    | CircleArrowLeft
    | CircleArrowUp
    | CircleArrowDown
    | Globe
    | Wrench
    | Tasks
    | Filter
    | Briefcase
    | Fullscreen
    | Dashboard
    | Paperclip
    | HeartEmpty
    | Link
    | Phone
    | Pushpin
    | Usd
    | Gbp
    | Sort
    | SortByAlphabet
    | SortByAlphabetAlt
    | SortByOrder
    | SortByOrderAlt
    | SortByAttributes
    | SortByAttributesAlt
    | Unchecked
    | Expand
    | CollapseDown
    | CollapseUp
    | LogIn
    | Flash
    | LogOut
    | NewWindow
    | Record
    | Save
    | Open
    | Saved
    | Import
    | Export
    | Send
    | FloppyDisk
    | FloppySaved
    | FloppyRemove
    | FloppySave
    | FloppyOpen
    | CreditCard
    | Transfer
    | Cutlery
    | Header
    | Compressed
    | Earphone
    | PhoneAlt
    | Tower
    | Stats
    | SdVideo
    | HdVideo
    | Subtitles
    | SoundStereo
    | SoundDolby
    | Sound51
    | Sound61
    | Sound71
    | CopyrightMark
    | RegistrationMark
    | CloudDownload
    | CloudUpload
    | TreeConifer
    | TreeDeciduous
    | Cd
    | SaveFile
    | OpenFile
    | LevelUp
    | Copy
    | Paste
    | Alert
    | Equalizer
    | King
    | Queen
    | Pawn
    | Bishop
    | Knight
    | BabyFormula
    | Tent
    | Blackboard
    | Bed
    | Apple
    | Erase
    | Hourglass
    | Lamp
    | Duplicate
    | PiggyBank
    | Scissors
    | Bitcoin
    | Btc
    | Xbt
    | Yen
    | Jpy
    | Ruble
    | Rub
    | Scale
    | IceLolly
    | IceLollyTasted
    | Education
    | OptionHorizontal
    | OptionVertical
    | MenuHamburger
    | ModalWindow
    | Oil
    | Grain
    | Sunglasses
    | TextSize
    | TextColor
    | TextBackground
    | ObjectAlignTop
    | ObjectAlignBottom
    | ObjectAlignHorizontal
    | ObjectAlignLeft
    | ObjectAlignVertical
    | ObjectAlignRight
    | TriangleRight
    | TriangleLeft
    | TriangleBottom
    | TriangleTop
    | Console
    | Superscript
    | Subscript
    | MenuLeft
    | MenuRight
    | MenuDown
    | MenuUp


{-| Type-checked Glyphicons.
-}
glyphicon : Glyphicon -> Html msg
glyphicon icon =
    span
        [ classList
            [ ( "glyphicon", True )
            , ( glyphiconClass icon, True )
            ]
        ]
        []


glyphiconClass : Glyphicon -> String
glyphiconClass icon =
    "glyphicon-"
        ++ case icon of
            Asterisk ->
                "asterisk"

            Plus ->
                "plus"

            Euro ->
                "euro"

            Eur ->
                "eur"

            Minus ->
                "minus"

            Cloud ->
                "cloud"

            Envelope ->
                "envelope"

            Pencil ->
                "pencil"

            Glass ->
                "glass"

            Music ->
                "music"

            Search ->
                "search"

            Heart ->
                "heart"

            Star ->
                "star"

            StarEmpty ->
                "star-empty"

            User ->
                "user"

            Film ->
                "film"

            ThLarge ->
                "th-large"

            Th ->
                "th"

            ThList ->
                "th-list"

            Ok ->
                "ok"

            Remove ->
                "remove"

            ZoomIn ->
                "zoom-in"

            ZoomOut ->
                "zoom-out"

            Off ->
                "off"

            Signal ->
                "signal"

            Cog ->
                "cog"

            Trash ->
                "trash"

            Home ->
                "home"

            File ->
                "file"

            Time ->
                "time"

            Road ->
                "road"

            DownloadAlt ->
                "download-alt"

            Download ->
                "download"

            Upload ->
                "upload"

            Inbox ->
                "inbox"

            PlayCircle ->
                "play-circle"

            Repeat ->
                "repeat"

            Refresh ->
                "refresh"

            ListAlt ->
                "list-alt"

            Lock ->
                "lock"

            Flag ->
                "flag"

            Headphones ->
                "headphones"

            VolumeOff ->
                "volume-off"

            VolumeDown ->
                "volume-down"

            VolumeUp ->
                "volume-up"

            Qrcode ->
                "qrcode"

            Barcode ->
                "barcode"

            Tag ->
                "tag"

            Tags ->
                "tags"

            Book ->
                "book"

            Bookmark ->
                "bookmark"

            Print ->
                "print"

            Camera ->
                "camera"

            Font ->
                "font"

            Bold ->
                "bold"

            Italic ->
                "italic"

            TextHeight ->
                "text-height"

            TextWidth ->
                "text-width"

            AlignLeft ->
                "align-left"

            AlignCenter ->
                "align-center"

            AlignRight ->
                "align-right"

            AlignJustify ->
                "align-justify"

            List ->
                "list"

            IndentLeft ->
                "indent-left"

            IndentRight ->
                "indent-right"

            FacetimeVideo ->
                "facetime-video"

            Picture ->
                "picture"

            MapMarker ->
                "map-marker"

            Adjust ->
                "adjust"

            Tint ->
                "tint"

            Edit ->
                "edit"

            Share ->
                "share"

            Check ->
                "check"

            Move ->
                "move"

            StepBackward ->
                "step-backward"

            FastBackward ->
                "fast-backward"

            Backward ->
                "backward"

            Play ->
                "play"

            Pause ->
                "pause"

            Stop ->
                "stop"

            Forward ->
                "forward"

            FastForward ->
                "fast-forward"

            StepForward ->
                "step-forward"

            Eject ->
                "eject"

            ChevronLeft ->
                "chevron-left"

            ChevronRight ->
                "chevron-right"

            PlusSign ->
                "plus-sign"

            MinusSign ->
                "minus-sign"

            RemoveSign ->
                "remove-sign"

            OkSign ->
                "ok-sign"

            QuestionSign ->
                "question-sign"

            InfoSign ->
                "info-sign"

            Screenshot ->
                "screenshot"

            RemoveCircle ->
                "remove-circle"

            OkCircle ->
                "ok-circle"

            BanCircle ->
                "ban-circle"

            ArrowLeft ->
                "arrow-left"

            ArrowRight ->
                "arrow-right"

            ArrowUp ->
                "arrow-up"

            ArrowDown ->
                "arrow-down"

            ShareAlt ->
                "share-alt"

            ResizeFull ->
                "resize-full"

            ResizeSmall ->
                "resize-small"

            ExclamationSign ->
                "exclamation-sign"

            Gift ->
                "gift"

            Leaf ->
                "leaf"

            Fire ->
                "fire"

            EyeOpen ->
                "eye-open"

            EyeClose ->
                "eye-close"

            WarningSign ->
                "warning-sign"

            Plane ->
                "plane"

            Calendar ->
                "calendar"

            Random ->
                "random"

            Comment ->
                "comment"

            Magnet ->
                "magnet"

            ChevronUp ->
                "chevron-up"

            ChevronDown ->
                "chevron-down"

            Retweet ->
                "retweet"

            ShoppingCart ->
                "shopping-cart"

            FolderClose ->
                "folder-close"

            FolderOpen ->
                "folder-open"

            ResizeVertical ->
                "resize-vertical"

            ResizeHorizontal ->
                "resize-horizontal"

            Hdd ->
                "hdd"

            Bullhorn ->
                "bullhorn"

            Bell ->
                "bell"

            Certificate ->
                "certificate"

            ThumbsUp ->
                "thumbs-up"

            ThumbsDown ->
                "thumbs-down"

            HandRight ->
                "hand-right"

            HandLeft ->
                "hand-left"

            HandUp ->
                "hand-up"

            HandDown ->
                "hand-down"

            CircleArrowRight ->
                "circle-arrow-right"

            CircleArrowLeft ->
                "circle-arrow-left"

            CircleArrowUp ->
                "circle-arrow-up"

            CircleArrowDown ->
                "circle-arrow-down"

            Globe ->
                "globe"

            Wrench ->
                "wrench"

            Tasks ->
                "tasks"

            Filter ->
                "filter"

            Briefcase ->
                "briefcase"

            Fullscreen ->
                "fullscreen"

            Dashboard ->
                "dashboard"

            Paperclip ->
                "paperclip"

            HeartEmpty ->
                "heart-empty"

            Link ->
                "link"

            Phone ->
                "phone"

            Pushpin ->
                "pushpin"

            Usd ->
                "usd"

            Gbp ->
                "gbp"

            Sort ->
                "sort"

            SortByAlphabet ->
                "sort-by-alphabet"

            SortByAlphabetAlt ->
                "sort-by-alphabet-alt"

            SortByOrder ->
                "sort-by-order"

            SortByOrderAlt ->
                "sort-by-order-alt"

            SortByAttributes ->
                "sort-by-attributes"

            SortByAttributesAlt ->
                "sort-by-attributes-alt"

            Unchecked ->
                "unchecked"

            Expand ->
                "expand"

            CollapseDown ->
                "collapse-down"

            CollapseUp ->
                "collapse-up"

            LogIn ->
                "log-in"

            Flash ->
                "flash"

            LogOut ->
                "log-out"

            NewWindow ->
                "new-window"

            Record ->
                "record"

            Save ->
                "save"

            Open ->
                "open"

            Saved ->
                "saved"

            Import ->
                "import"

            Export ->
                "export"

            Send ->
                "send"

            FloppyDisk ->
                "floppy-disk"

            FloppySaved ->
                "floppy-saved"

            FloppyRemove ->
                "floppy-remove"

            FloppySave ->
                "floppy-save"

            FloppyOpen ->
                "floppy-open"

            CreditCard ->
                "credit-card"

            Transfer ->
                "transfer"

            Cutlery ->
                "cutlery"

            Header ->
                "header"

            Compressed ->
                "compressed"

            Earphone ->
                "earphone"

            PhoneAlt ->
                "phone-alt"

            Tower ->
                "tower"

            Stats ->
                "stats"

            SdVideo ->
                "sd-video"

            HdVideo ->
                "hd-video"

            Subtitles ->
                "subtitles"

            SoundStereo ->
                "sound-stereo"

            SoundDolby ->
                "sound-dolby"

            Sound51 ->
                "sound-5-1"

            Sound61 ->
                "sound-6-1"

            Sound71 ->
                "sound-7-1"

            CopyrightMark ->
                "copyright-mark"

            RegistrationMark ->
                "registration-mark"

            CloudDownload ->
                "cloud-download"

            CloudUpload ->
                "cloud-upload"

            TreeConifer ->
                "tree-conifer"

            TreeDeciduous ->
                "tree-deciduous"

            Cd ->
                "cd"

            SaveFile ->
                "save-file"

            OpenFile ->
                "open-file"

            LevelUp ->
                "level-up"

            Copy ->
                "copy"

            Paste ->
                "paste"

            Alert ->
                "alert"

            Equalizer ->
                "equalizer"

            King ->
                "king"

            Queen ->
                "queen"

            Pawn ->
                "pawn"

            Bishop ->
                "bishop"

            Knight ->
                "knight"

            BabyFormula ->
                "baby-formula"

            Tent ->
                "tent"

            Blackboard ->
                "blackboard"

            Bed ->
                "bed"

            Apple ->
                "apple"

            Erase ->
                "erase"

            Hourglass ->
                "hourglass"

            Lamp ->
                "lamp"

            Duplicate ->
                "duplicate"

            PiggyBank ->
                "piggy-bank"

            Scissors ->
                "scissors"

            Bitcoin ->
                "bitcoin"

            Btc ->
                "btc"

            Xbt ->
                "xbt"

            Yen ->
                "yen"

            Jpy ->
                "jpy"

            Ruble ->
                "ruble"

            Rub ->
                "rub"

            Scale ->
                "scale"

            IceLolly ->
                "ice-lolly"

            IceLollyTasted ->
                "ice-lolly-tasted"

            Education ->
                "education"

            OptionHorizontal ->
                "option-horizontal"

            OptionVertical ->
                "option-vertical"

            MenuHamburger ->
                "menu-hamburger"

            ModalWindow ->
                "modal-window"

            Oil ->
                "oil"

            Grain ->
                "grain"

            Sunglasses ->
                "sunglasses"

            TextSize ->
                "text-size"

            TextColor ->
                "text-color"

            TextBackground ->
                "text-background"

            ObjectAlignTop ->
                "object-align-top"

            ObjectAlignBottom ->
                "object-align-bottom"

            ObjectAlignHorizontal ->
                "object-align-horizontal"

            ObjectAlignLeft ->
                "object-align-left"

            ObjectAlignVertical ->
                "object-align-vertical"

            ObjectAlignRight ->
                "object-align-right"

            TriangleRight ->
                "triangle-right"

            TriangleLeft ->
                "triangle-left"

            TriangleBottom ->
                "triangle-bottom"

            TriangleTop ->
                "triangle-top"

            Console ->
                "console"

            Superscript ->
                "superscript"

            Subscript ->
                "subscript"

            MenuLeft ->
                "menu-left"

            MenuRight ->
                "menu-right"

            MenuDown ->
                "menu-down"

            MenuUp ->
                "menu-up"
