"
I translate some HTML accents to their UTF-8 equivalents.

Caveat: I only translate accents actually found in the Bellairs pages.
"
Class {
	#name : #BellairsRewriteMaps,
	#superclass : #Object,
	#instVars : [
		'htmlAccents',
		'patchCountries'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #converting }
BellairsRewriteMaps >> htmlAccents [
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
BellairsRewriteMaps >> patchCountries [
	"NB: We only translate the accents that actually appear in our input."

	<gtExample>
	^ patchCountries
		ifNil: [ patchCountries := {'France </li>' -> 'France</li>'.
					'Sorbonne Universit&eacute;, France / Universit&eacute; de Yaound&eacute; I, Cameroun</li>'
						-> 'Sorbonne Universit&eacute;/Universit&eacute; de Yaound&eacute; I, France/Cameroun</li>'.
					'Assistant Professor, ' -> ''.
					'Professor, ' -> ''} asDictionary ]
]

{ #category : #converting }
BellairsRewriteMaps >> translateLine: aLine [
	| theLine |
	theLine := aLine.
	theLine := self translateLine: theLine using: self htmlAccents.
	theLine := self translateLine: theLine using: self patchCountries.
	^ theLine
]

{ #category : #converting }
BellairsRewriteMaps >> translateLine: aLine using: aDictionary [
	| updatedLine |
	updatedLine := aLine.
	aDictionary keys
		do: [ :key | updatedLine := updatedLine copyReplaceAll: key with: (aDictionary at: key) ].
	^ updatedLine
]
