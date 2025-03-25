Class {
	#name : #LeTaggedPageCollection,
	#superclass : #ALePageCollection,
	#instVars : [
		'tagCount',
		'maxTags',
		'tagStats',
		'cumulativeTagStats',
		'tags'
	],
	#category : #'ONGtExperiments-Lepiter'
}

{ #category : #'instance creation' }
LeTaggedPageCollection class >> forDatabase: aDatabase [
	^ self forPages: (aDatabase pages select: #isNamedPage)
]

{ #category : #'instance creation' }
LeTaggedPageCollection class >> forPages: aPageCollection [
	^ (self withAll: aPageCollection) yourself
]

{ #category : #'instance creation' }
LeTaggedPageCollection class >> forPages: aPageCollection andTags: aTagPageCollection [
	^ (self withAll: aPageCollection)
		tags: aTagPageCollection;
		yourself
]

{ #category : #'instance creation' }
LeTaggedPageCollection class >> forPrimaryDatabase [
	^ self forDatabase: LeDatabase primaryDB
]

{ #category : #utility }
LeTaggedPageCollection >> cumulativeTagCount [
	"NB: clone the tagCount to avoid modifying the original."

	| keys dict |
	dict := (self tagCount collect: [ :assoc | assoc key -> assoc value copy ])
			asDictionary.
	keys := dict keys sorted.
	keys
		do: [ :i | keys select: [ :k | k > i ] thenDo: [ :k | (dict at: i) addAll: (dict at: k) ] ].
	^ dict associations sorted
]

{ #category : #statistics }
LeTaggedPageCollection >> cumulativeTagStats [
	^ cumulativeTagStats
		ifNil: [ cumulativeTagStats := self cumulativeTagCount
					collect: [ :assoc | 
						{assoc key.
							assoc value size.
							(assoc value flatCollect: #explicitReferences) removeDuplicates size.
							self titlesFor: assoc value.
							[ self tagsAndPagesTagged: assoc value ]} ] ]
]

{ #category : #constant }
LeTaggedPageCollection >> defaultMaxTags [
	^ 20
]

{ #category : #utility }
LeTaggedPageCollection >> fcaContext [
	| tagCollection |
	tagCollection := self topTags.
	^ (FCAContext
		elements: self
		properties: tagCollection
		propertyMap: [ :page | page tags intersection: tagCollection ])
		printMessage: #title;
		yourself
]

{ #category : #view }
LeTaggedPageCollection >> gtCumulativeTagStatsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Cumulative Tag Statistics';
		priority: 25;
		items: [ self cumulativeTagStats ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'References'
			text: [ :item | 'Tags on ' , item first gtDisplayString , ' or more pages' ]
			width: 200;
		column: '# tags'
			text: [ :item | item second ]
			width: 80;
		column: '# pages'
			text: [ :item | item third ]
			width: 80;
		column: 'Tags'
			text: [ :item | item fourth ]
			width: 400;
		send: [ :item | item last value ];
		actionUpdateButton
]

{ #category : #view }
LeTaggedPageCollection >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items';
		priority: 10;
		items: [ self ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' 
			text: [ :eachItem | eachItem title ].
]

{ #category : #view }
LeTaggedPageCollection >> gtLatticeFor: aView [
	<gtView>
	^ aView forward
		title: 'Lattice';
		priority: 30;
		object: [ self fcaContext ];
		view: #gtLatticeFor:
]

{ #category : #view }
LeTaggedPageCollection >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 15;
		items: [ self overview ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Description'
			text: [ :item | item first gtDisplayString ]
			width: 120;
		column: 'Value'
			text: [ :item | item second ]
			width: 400;
		send: [ :item | item last ];
		actionUpdateButton
]

{ #category : #spotter }
LeTaggedPageCollection >> gtSpotterForPagesByContentFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		title: 'Page contents';
		items: [ self pages ];
		itemName: #contentAsString;
		filterBySubstring;
		sendCategory: [ :aCategory :aStep :thisSearch | self class forPages: aCategory items contents ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
LeTaggedPageCollection >> gtSpotterForPagesByTitlesFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 10;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #title;
		filterBySubstring;
		sendCategory: [ :aCategory :aStep :thisSearch | self class forPages: aCategory items contents ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #view }
LeTaggedPageCollection >> gtTagStatsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Tag Statistics';
		priority: 20;
		items: [ self tagStats ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'References'
			text: [ :item | 'Tags on ' , item first gtDisplayString , ' pages' ]
			width: 120;
		column: '# tags'
			text: [ :item | item second ]
			width: 80;
		column: '# pages'
			text: [ :item | item third ]
			width: 80;
		column: 'Tags'
			text: [ :item | item fourth ]
			width: 400;
		send: [ :item | item last value ];
		actionUpdateButton
]

{ #category : #accessing }
LeTaggedPageCollection >> maxTags [
	^ maxTags ifNil: [ maxTags := self defaultMaxTags ]
]

{ #category : #accessing }
LeTaggedPageCollection >> maxTags: aNumber [
	maxTags := aNumber
]

{ #category : #view }
LeTaggedPageCollection >> overview [
	^ {{'# Pages'.
			self size.
			self}.
		{'# Tags'.
			self tags size.
			self class withAll: self tags}}
]

{ #category : #accessing }
LeTaggedPageCollection >> pages [
	^ self items
]

{ #category : #statistics }
LeTaggedPageCollection >> tagCount [
	| countDict |
	^ tagCount
		ifNil: [ countDict := Dictionary new.
			self tags
				do: [ :tag | 
					(countDict
						at: tag explicitReferences size
						ifAbsentPut: [ OrderedCollection new ]) addLast: tag ].
			tagCount := countDict associations sorted ]
]

{ #category : #statistics }
LeTaggedPageCollection >> tagStats [
	^ tagStats
		ifNil: [ tagStats := self tagCount
					collect: [ :assoc | 
						{assoc key.
							assoc value size.
							(assoc value flatCollect: #explicitReferences) removeDuplicates size.
							(self titlesFor: assoc value).
							[ self tagsAndPagesTagged: assoc value ]} ] ]
]

{ #category : #accessing }
LeTaggedPageCollection >> tags [
	"If not defined, extract from the pages."

	^ tags
		ifNil: [ tags := ((self select: #isNamedPage) flatCollect: #tags) removeDuplicates
					sortedAs: #title ]
]

{ #category : #accessing }
LeTaggedPageCollection >> tags: anObject [
	tags := anObject
]

{ #category : #querying }
LeTaggedPageCollection >> tagsAndPagesTagged: aTagCollection [
	^ self class
		forPages: (((aTagCollection flatCollect: #explicitReferences) copyWithAll: aTagCollection)
				removeDuplicates sortedAs: #title)
		andTags: aTagCollection
]

{ #category : #accessing }
LeTaggedPageCollection >> titlesFor: aTagCollection [
	| theTags maxlength |
	maxlength := 10 min: aTagCollection size.
	theTags := (aTagCollection asOrderedCollection collect: #title) sorted
			copyFrom: 1
			to: maxlength.
	aTagCollection size > maxlength ifTrue: [ theTags addLast: '...' ].
	^ ' ' join: theTags
]

{ #category : #utility }
LeTaggedPageCollection >> topTags [
	"If there are too many tags, select those that are used most often."

	^ self tags size <= self maxTags
		ifTrue: [ self tags ]
		ifFalse: [ (((self flatCollect: #tags) select: [ :t | self tags includes: t ]) asBag
				sortedCounts copyFrom: 1 to: self maxTags) collect: #value ]
]
