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
					'&auml;' -> 'ä'.
					'&copy;' -> '©'} asDictionary ]
]
