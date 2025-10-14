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
					', Assistant Professor, ' -> ', '.
					', Associate Professor, ' -> ', '.
					', Professor, ' -> ', '.
					'Sorbonne Universit&eacute;, France / Universit&eacute; de Yaound&eacute; I, Cameroun</li>'
						-> 'Sorbonne Universit&eacute;/Universit&eacute; de Yaound&eacute; I, France/Cameroun</li>'.
					',  Universitat Oberta de Catalunya, Spain / CEA List, France</li>'
						-> ',  Universitat Oberta de Catalunya/CEA List, Spain/France</li>'.
					', &Eacute;cole de technologie sup&eacute;rieure, Universit&eacute; du Qu&eacute;bec, Canada</li>'
						-> ', &Eacute;cole de technologie sup&eacute;rieure - Universit&eacute; du Qu&eacute;bec, Canada</li>'}
					asDictionary ]
]

{ #category : #converting }
BellairsRewriteMaps >> translateLine: aLine [
	"NB: fix accents last so rewrite rules apply to the version with HTML accents."

	| theLine |
	theLine := aLine.
	theLine := self translateLine: theLine using: self patchCountries.
	theLine := self translateLine: theLine using: self htmlAccents.
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
