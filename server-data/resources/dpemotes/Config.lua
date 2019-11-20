Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- You can disable the (F3) menu here / change the keybind
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = true,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgur.com/kgzvDwQ.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = false,
	RagdollKeybind = 303, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = true,
}

Config.Languages = {
  ['en'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Dance Emotes",
        ['propemotes'] = "📦 Prop Emotes",
        ['keybindemotes'] = "🌟 Keybind",
        ['keybindinfo'] = "Select an emote here to set it as your bound emote.",
        ['rkeybind'] = "Reset Keybind",
        ['prop2info'] = "❓ Prop Emotes can be located at the end",
        ['set'] = "Set (",
        ['setboundemote'] = ") to be your bound emote?",
        ['newsetemote'] = "~w~ is now your bound emote, press ~g~CapsLock~w~ to use it.",
        ['cancelemote'] = "Cancel Emote",
        ['cancelemoteinfo'] = "~r~X~w~ Cancels the currently playing emote",
        ['walkingstyles'] = "Walking Styles",
        ['resetdef'] = "Reset to default",
        ['normalreset'] = "Normal (Reset)",
        ['moods'] = "Moods",
        ['infoupdate'] = "Information",
        ['infoupdateav'] = "Information (Update available)",
        ['infoupdateavtext'] = "An update is available, get the latest version from ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Suggestions?",
        ['suggestionsinfo'] = "'dullpear_dev' on FiveM forums for any feature/emote suggestions! ✉️",
        ['notvaliddance'] = "is not a valid dance.",
        ['notvalidemote'] = "is not a valid emote.",
        ['nocancel'] = "No emote to cancel.",
        ['maleonly'] = "This emote is male only, sorry!",
        ['emotemenucmd'] = "Do /emotemenu for a menu.",
        ['shareemotes'] = "👫 Shared Emotes",
        ['shareemotesinfo'] = "Invite a nearby person to emote",
        ['sharedanceemotes'] = "🕺 Shared Dances",
        ['notvalidsharedemote'] = "is not a valid shared emote.",
        ['sentrequestto'] = "Sent request to ~y~",
        ['nobodyclose'] = "Nobody ~r~close~w~ enough.",
        ['doyouwanna'] = "~y~Y~w~ принять, ~r~L~w~ отказать (~g~",
        ['refuseemote'] = "Emote refused.",
        ['makenearby'] = "makes the nearby player play",
        ['camera'] = "Press ~y~G~w~ to use camera flash.",
        ['makeitrain'] = "Press ~y~G~w~ to make it rain.",
        ['pee'] = "Hold ~y~G~w~ to pee.",
  },
  ['fr'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Emotes de danse",
        ['propemotes'] = "📦 Em Prop Emotes",
        ['keybindemotes'] = "🌟 Keybind",
        ['keybindinfo'] = "Sélectionnez une emote ici pour la définir comme emote liée.",
        ['rkeybind'] = "Réinitialiser le raccourci clavier",
        ['prop2info'] = "❓ Prop Emotes peuvent être situés à la fin",
        ['set'] = "Set (",
        ['setboundemote'] = ") pour être votre emote lié?",
        ['newsetemote'] = "~w~ est maintenant votre emote liée, appuyez sur ~g~CapsLock~w~ pour l'utiliser.",
        ['cancelemote'] = "Annuler Emote",
        ['cancelemoteinfo'] = "~r~X~w~ Annule l'emote en cours de lecture",
        ['walkingstyles'] = "Styles de marche",
        ['resetdef'] = "Réinitialiser aux valeurs par défaut",
        ['normalreset'] = "Normal (réinitialiser)",
        ['moods'] = "Humeurs",
        ['infoupdate'] = "Information",
        ['infoupdateav'] = "Information (Mise à jour disponible)",
        ['infoupdateavtext'] = "Une mise à jour est disponible ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Suggestions?",
        ['suggestionsinfo'] = "'dullpear_dev' sur les forums FiveM pour toutes les suggestions de fonction / emote! ✉️",
		['notvaliddance'] = "n'est pas une danse valide",
        ['notvalidemote'] = "n'est pas un emote valide",
        ['nocancel'] = "Pas d'emote à annuler",
        ['maleonly'] = "Cet emote est réservé aux hommes, désolé!",
        ['emotemenucmd'] = "Do /emotemenu pour un menu",
        ['shareemotes'] = "👫 Em Emotes partagées",
        ['shareemotesinfo'] = "Inviter une personne proche à emoter",
        ['sharedanceemotes'] = "🕺 Dances partagées",
        ['notvalidsharedemote'] = "n'est pas un emote partagé valide.",
        ['sentrequestto'] = "Demande envoyée à ~g~",
        ['nobodyclose'] = "Personne assez proche.",
        ['doyouwanna'] = "~y~Y~w~ accepter, ~r~L~w~ refuser (~g~",
        ['refuseemote'] = "Emote refusée.",
        ['makenearby'] = "fait jouer le joueur à proximité",
        ['camera'] = "Presse ~y~G~w~ utiliser le flash de l'appareil.",
        ['makeitrain'] = "Presse ~y~G~w~ jeter de l'argent.",
        ['pee'] = "Tenir ~y~G~w~ faire pipi.",
  },
  ['de'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Tanz-Emotes",
        ['propemotes'] = "📦 Prop-Emotes",
        ['keybindemotes'] = "🌟 Keybind",
        ['keybindinfo'] = "Wählen Sie hier ein Emote aus, um es als gebundenes Emote festzulegen.",
        ['rkeybind'] = "Keybind zurücksetzen",
        ['prop2info'] = "❓ Prop-Emotes können am Ende platziert werden",
        ['set'] = "Set (",
        ['setboundemote'] = ") soll dein gebundenes Emote sein?",
        ['newsetemote'] = "~w~ ist jetzt dein gebundenes Emote, drücke ~g~CapsLock~w~, um es zu verwenden.",
        ['cancelemote'] = "Emote abbrechen",
        ['cancelemoteinfo'] = "~r~ X ~w~ Bricht das aktuell wiedergegebene Emote ab",
        ['walkingstyles'] = "Gehstile",
        ['resetdef'] = "Auf Standard zurücksetzen",
        ['normalreset'] = "Normal (Zurücksetzen)",
        ['moods'] = "Stimmungen",
        ['infoupdate'] = "Information",
        ['infoupdateav'] = "Information (Update verfügbar)",
        ['infoupdateavtext'] = "Eine Aktualisierung ist verfügbar ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Vorschläge?",
        ['suggestionsinfo'] = "'dullpear_dev' in FiveM-Foren für alle Feature- / Emote-Vorschläge! ✉️",
        ['notvaliddance'] = "ist kein gültiger Tanz",
        ['notvalidemote'] = "ist kein gültiges Emote",
        ['nocancel'] = "Kein Emote zum Abbrechen",
        ['maleonly'] = "Dieses Emote ist nur männlich, sorry!",
        ['emotemenucmd'] = "Do /emotemenu für ein Menü",
        ['shareemotes'] = "👫 Geteilte Emotes",
        ['shareemotesinfo'] = "Laden Sie eine Person in Ihrer Nähe zum Emoten ein",
        ['sharedanceemotes'] = "🕺 Geteilte Tänze",
        ['notvalidsharedemote'] = "ist kein gültiges geteiltes Emote.",
        ['sentrequestto'] = "Gesendete Anfrage an ~g~",
        ['nobodyclose'] = "Niemand ist nah genug dran.",
        ['doyouwanna'] = "~y~Y~w~ zu akzeptieren, ~r~L~w~ zu verweigern (~g~",
        ['refuseemote'] = "Emote abgelehnt.",
        ['makenearby'] = "Lässt den Spieler in der Nähe spielen",
        ['camera'] = "Drücken ~y~G~w~ Kamerablitz verwenden.",
        ['makeitrain'] = "Drücken ~y~G~w~ Geld werfen.",
        ['pee'] = "Halt ~y~G~w~ urinieren.",
  },
  ['sv'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Dans Emotes",
        ['propemotes'] = "📦 Objekt Emotes",
        ['keybindemotes'] = "🌟 Favorit",
        ['keybindinfo'] = "Välj en emote här för att ställa in den som din favorit emote.",
        ['rkeybind'] = "Återställ Keybind",
        ['prop2info'] = "❓ Objekt Emotes finns längst ner i listan.",
        ['set'] = "Sätt (",
        ['setboundemote'] = ") till din favorit emote?",
        ['newsetemote'] = "~w~ är nu din favorit emote, tryck ~g~CapsLock~w~ för att använda den.",
        ['cancelemote'] = "Avbryt Emote",
        ['cancelemoteinfo'] = "~r~X~w~ Avbryter det emote som för närvarande används.",
        ['walkingstyles'] = "Walking Stil",
        ['resetdef'] = "Återställ till standard",
        ['normalreset'] = "Normal (Återställ)",
        ['moods'] = "Humör",
        ['infoupdate'] = "Information",
        ['infoupdateav'] = "Information (Uppdatering tillgänglig)",
        ['infoupdateavtext'] = "En uppdatering är tillgänglig ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Förslag?",
        ['suggestionsinfo'] = "'dullpear_dev' på FiveM-forum för alla funktioner/emote-förslag! ✉️",
        ['notvaliddance'] = "är inte en giltig dans",
        ['notvalidemote'] = "är inte en giltig emote",
        ['nocancel'] = "Ingen emote att avbryta",
        ['maleonly'] = "Den här emoten är endast för män, ledsen!",
        ['emotemenucmd'] = "Gör /emotemenu för en meny",
        ['shareemotes'] = "👫 Delade Emotes",
        ['shareemotesinfo'] = "Bjud in en någon nära för en emote",
        ['sharedanceemotes'] = "🕺 Delade Danser",
        ['notvalidsharedemote'] = "är inte en giltig delad emote.",
        ['sentrequestto'] = "Skickad förfrågan till ~g~",
        ['nobodyclose'] = "Ingen ~r~nära~w~ tillräckligt.",
        ['doyouwanna'] = "~y~Y~w~ för att acceptera, ~r~L~w~ för att vägra (~g~",
        ['refuseemote'] = "Emote vägrades.",
        ['makenearby'] = "andra personen spelar",
        ['camera'] = "Tryck ~y~G~w~ för att använda blixt.",
        ['makeitrain'] = "Tryck ~y~G~w~ för att kasta pengar.",
        ['pee'] = "Håll ~y~G~w~ att kissa.",
  },
}
