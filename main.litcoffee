# Site Structure

    pages = 
        "Home": 
            url: "home"
        "Apps":
            url: "apps"
        #"Writings":
        #    url: "writings"
        #"Images":
        #    url: "images"
        "Rasmus Erik":
            url: "rasmuserik"


## Apps

    apps =
        # timelog:
        # findaday:
        # notescore:
        # findaday:
        combigame:
            title: "CombiGame"
            run: "http://combigame.com"
            desc: "Logical game, inspired by a card game"
        tsartnoc:
            title: "Tsar Tnoc"
            run: "http://tsartnoc.solsort.com"
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

## Writings

    writings = [
        "techstack",
        "pricingstructure"
    ]

# Code

    if Meteor.isClient
        Template.body.content = ->
            Template[location.pathname.slice(1).replace(/[^a-zA-Z0-9].*/, "")]?() or Template.home()

        Template.home.events
            "click #contactMe": ->
                obj =
                    field: $("#yourField").val()
                    email: $("#yourEmail").val()
                    name: $("#yourName").val()
                qp.log "contact me", obj
                Meteor.call "contactMe", obj


        Template.apps.rows = -> 
            result = []
            acc = []
            for key, val of apps
                val.name = key
                if acc.length is 3
                    result.push {apps: acc}
                    acc = []
                acc.push val
            result.push {apps: acc}
            result

        Template.topbar.pages = -> 
            result = for key, val of pages 
                title: key
                url: val.url
                active: val.url is location.pathname.slice(1)
            result

    if Meteor.isServer
        Meteor.startup ->
            console.log "started"

        Meteor.methods
            contactMe: (obj) ->
                Email.send
                    from: "meteor@solsort.com"
                    to: "rasmuserik@solsort.com"
                    subject: "solsort.com contact me"
                    text: JSON.stringify obj
## Util
