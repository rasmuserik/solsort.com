# ![logo](https://solsort.com/_logo.png) Site Structure

    pages = 
        "Home": 
            url: "home"
        "Stuff":
            url: "apps"
        "Writings":
            url: "writings"
        #"Images":
        #    url: "images"
        "Rasmus Erik":
            url: "rasmuserik"


## Apps

    apps = 
      "Rasmus Erik":
        link: "http://solsort.com/rasmuserik"
        desc: "Contact info, and more about the creator of these things"

      html5cnug:
        title: "Slides: HTML5"
        date: "2013-05-22"
        tags: "presentation, html5, cnug"
        link: "http://rasmuserik.com/html5/cnug2013-slides.html"
        source: "https://github.com/rasmuserik/app-speeding"
        desc: "Slides for presentation done at CNUG.dk"
        time: "3 days study/preparation for presentation, 1 hour presentation"

      speeding:
        title: "Speeding visualisation"
        tags: "coffeescript, hammertime, visualisation"
        date: "2013-05-15"
        link: "http://speeding.solsort.com"
        source: "https://github.com/rasmuserik/app-speeding"
        desc: "Visualiseringskode for vejdirektoratet - layout baseret på tidligere udgave"
        time: "5 hours trying to optimise original outsourced code, then 10 hours reimplementing it"

      Dragimation:
        date: "2013-04-30"
        tags: "coffeescript, hammertime, visualisation, html5"
        link: "http://dragimation.solsort.com"
        source: "https://github.com/rasmuserik/app-dragimation"
        desc: "Dragging animation special effect - as requested for the development of legoland billund resort web page."

      CombiGame:
        link: "http://solsort.com/_/combigame.com"
        desc: "Logical game, inspired by a card game"
        date: "2012-03-26"

      "Tsar Tnoc":
        link: "http://tsartnoc.solsort.com"
        desc: "Result of a ludum dare hackathon."
        date: "2012-07-15"

      BlobShot:
        link: "http://blobshot.solsort.com"
        desc: "Result of the 5apps hackathon."
        date: "2012-05-06"

      NoteScore:
        desc: "Note learning app"
        link: "http://old.solsort.com/#notescore"
        "Android App": "https://market.android.com/details?id=dk.solsort.notescore"
        Source: "https://github.com/rasmuserik/notescore"
        date: "2011-08"

      dkcities:
        title: "Danske Byer"
        link: "http://old.solsort.com/#dkcities"
        source: "https://github.com/rasmuserik/dkcities"
        desc: 'Learning "game" for the geography of Denmark.'
        date: "2011-08"

      CuteEngine:
        link: "http://solsort.com/_/solsort.dk/planetcute"
        Source: "https://github.com/rasmuserik/planetcute"
        desc: "Game engine experiment"
        date: "2011-08"
        time: "3 days"

      "Productivity Hacks":
        kind: "html"
        desc: "Notes for a presentation on productivity hacks. Keywords of my aproaches to handle the world."
        date: "2013-04-30"

      "EuroCards":
        tags: "card game"
        link: "http://solsort.com/_/www.thegamecrafter.com/games/EuroCards"
        desc: "top-trump like card game for learning facts about european countries"
        date: "2012-06-20"

      "Pricing scale":
        kind: "html"
        link: "http://solsort.com/pricing-scale"
        desc: "Tool for pricing and estimating cost."
        date: "2013"

      "Skrivetips":
        kind: "html"
        lang: "da"
        link: "http://solsort.com/skrivetips"
        desc: "Tips / noter om skrivning, herunder også struktur for videnskabelige rapporter. Tips for effective writing (in Danish)."
        date: "2005"

      "Presentation evaluation notes":
        kind: "html"
        link: "http://solsort.com/presentation-evaluation-notes"
        desc: "Checklist / notes for giving feedback on presentations. Useful for Toastmasters and similar."
        date: "2012-03-18"

      # Master thesis
      # sourceforge image transform pocr
      # lightscript 2
      # yolan 2
      # BSc. thesis
      # Filtering contexts paper
      # Tempo paper
      # Poetry
      # Graphics
      # Music
      # Photo albums
      # Rasmus Erik
      # CV

    for key, val of apps
        val.title = key if not val.title
        val.name = key.toLowerCase().replace(/[^a-z0-9]/g, "-") if not val.name
        console.log val.name, key

# Code

    if Meteor.isClient
        Template.body.content = ->
            Template[location.pathname.slice(1).replace(/[^a-zA-Z0-9-].*/, "")]?() or Template.home()

        Template.home.events
            "click #contactMe": ->
                $("#contactMe").addClass("disabled")
                obj =
                    field: $("#yourField").val()
                    email: $("#yourEmail").val()
                    name: $("#yourName").val()
                qp.log "contact me", obj
                $(".landingLetter").addClass "grayedOut"
                $("#contactMe").addClass "grayedOut"
                $("#landingLetterSending").css("display", "block")
                $("#landingLetterSending").css("opacity", "1")
                Meteor.call "contactMe", obj, contactResultHandler

        contactResultHandler = (err, result) ->
            qp.log "handle submit result", {err: err, result: result}
            $("#landingLetterSending").css("opacity", "0")
            setTimeout (->
                $("#landingLetterSending").css 
                    display: "none"
                    opacity: 1
            ), 1000
            $(".landingLetter").removeClass "grayedOut"
            $("#contactMe").removeClass "grayedOut"
            if not err
                $("#yourField").val ""
                $("#yourEmail").val ""
                $("#yourName").val ""
            $("#contactMe").removeClass("disabled")
            console.log err, result


        Template.home.rows = -> 
            result = []
            acc = []
            for key, val of apps
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
