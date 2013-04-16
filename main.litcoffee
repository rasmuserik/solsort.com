# Site Structure

    pages = 
        "Home": 
            url: "/"
        "Apps":
            url: "/apps"
        #"Writings":
        #    url: "/writings"
        #"Images":
        #    url: "/images"
        "Rasmus Erik":
            url: "/rasmuserik"


## Apps

    apps =
        # timelog:
        # findaday:
        # notescore:
        # findaday:
        combigame:
            title: "Combigame"
            run: "http://combigame.com"
            desc: "Logical game, inspired by a card game"
        tsartnoc:
            title: "Tsar Tnoc"
            run: "http://solsort.com/tsar_tnoc"
            desc: "Result of a ludum dare hackathon."
        blobshot:
            title: "BlobShot"
            run: "http://solsort.com/apps/blobshot"
            desc: "Result of the 5apps hackathon."
        dkcities:
            title: "Danske Byer"
            run: "http://solsort.com/solsort/#dkcities"
            desc: 'Learning "game" for the geography of Denmark.'
        cuteengine:
            title: "CuteEngine"
            run: "http://solsort.dk/planetcute"
            desc: "Game engine experiment"

    apps = for key, val of apps
        val.name = key
        val


## Writings

    writings = [
        "techstack"
    ]

# Code

    if Meteor.isClient
        Template.appPage.apps = -> apps
        Template.topbar.pages = -> for key, val of pages
            title: key
            url: val.url
            active: val.url is location.pathname
        Template.hello.greeting = -> "Welcome to solsort.com."

        Template.hello.events
            'click input': ->
                console?.log "You pressed the button"

    if Meteor.isServer
        Meteor.startup ->
            console.log "started"
## Util
