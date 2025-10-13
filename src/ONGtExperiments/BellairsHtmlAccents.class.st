"
I translate some HTML accents to their UTF-8 equivalents.

Caveat: I only translate accents actually found in the Bellairs pages.
"
Class {
	#name : #BellairsHtmlAccents,
	#superclass : #Object,
	#instVars : [
		'htmlAccents'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #converting }
BellairsHtmlAccents >> htmlAccents [
	"NB: We only translate the accents that actually appear in our input."

	<gtExample>
	^ htmlAccents
		ifNil: [ htmlAccents := {'&agrave;' -> 'à'.
					'&aacute;' -> 'á'.
					'&Eacute;' -> 'É'.
					'&oacute;' -> 'ó'.
					'&atilde;' -> 'ã'.
					'&Oslash;' -> 'Ø'.
					'&ntilde;' -> 'ñ'.
					'&ouml;' -> 'ö'.
					'&ocirc;' -> 'ô'.
					'&egrave;' -> 'è'.
					'&eacute;' -> 'é'.
					'&uuml;' -> 'ü'.
					'&auml;' -> 'ä'} asDictionary ]
]

{ #category : #converting }
BellairsHtmlAccents >> translateLine: aLine [
	| updatedLine |
	updatedLine := aLine.
	self htmlAccents keys
		do: [ :accent | 
			updatedLine := updatedLine
					copyReplaceAll: accent
					with: (self htmlAccents at: accent) ].
	^ updatedLine
]
