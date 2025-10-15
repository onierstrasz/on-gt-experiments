Trait {
	#name : #TParticipationGroupViews,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #requirement }
TParticipationGroupViews >> countries [
	^ self explicitRequirement
]

{ #category : #views }
TParticipationGroupViews >> gtCountriesFor: aView [
<gtView>
	^ aView columnedList
		title: 'Countries';
		priority: 30;
		items: [ self countries sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Country'
			text: [ :each | each value gtDisplayString ]
			width: 300;
		column: '# Workshops'
			text: [ :each | each workshops size ]
			width: 100;
		column: '# Institutions'
			text: [ :each | each institutions size ]
			width: 100;
		column: '# Persons'
			text: [ :each | each persons size ]
			width: 100;
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
TParticipationGroupViews >> gtGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 60;
		painting: [ :aMondrian | self workshopPersonsGraph: aMondrian ];
		actionUpdateButton
]

{ #category : #views }
TParticipationGroupViews >> gtInstitutionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Institutions';
		priority: 30;
		items: [ self institutions sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Institution'
			text: [ :each | each value gtDisplayString ]
			width: 300;
		column: 'Country'
			text: [ :each | each country ]
			width: 200;
		column: '# Persons'
			text: [ :each | each persons size ]
			width: 100;
		column: '# Workshops'
			text: [ :each | each workshops size ]
			width: 100;
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
TParticipationGroupViews >> gtParticipationsFor: aView [
	<gtView>
	^ aView forward
		title: 'Participations';
		priority: 50;
		object: [ self participations ];
		view: #gtParticipationsFor:
]

{ #category : #views }
TParticipationGroupViews >> gtPersonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Persons';
		priority: 20;
		items: [ self personsSorted ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Person'
			text: [ :each | each value gtDisplayString ]
			width: 250;
		column: '# Workshops'
			text: [ :each | each workshops size ]
			width: 100;
		column: 'Roles'
			text: [ :each | each rolesIn: self participations ]
			width: 180;
		column: '# Urls'
			text: [ :each | each urls size ]
			width: 80;
		column: 'Institution'
			text: [ :each | each institution ]
			width: 200;
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #searching }
TParticipationGroupViews >> gtSpotterForParticipations: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Fields';
		priority: 10;
		items: [ self participations items ];
		itemsLimit: Float infinity;
		itemName: #asString;
		sendCategory: [ :aCategory :aStep :thisSearch | 
			(self participations
				participationGroupFrom: (aCategory items contents collect: #data))
				searchString: aStep searchQuery;
				yourself ];
		filterBySubstring
]

{ #category : #views }
TParticipationGroupViews >> gtWorkshopsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Workshops';
		priority: 10;
		items: [ self workshops sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Workshop'
			text: [ :each | each value gtDisplayString ]
			width: 400;
		column: '# Participants'
			text: [ :each | each persons size ]
			width: 100;
		column: '# Organizers'
			text: [ :each | each organizers size ]
			width: 100;
		column: '# Countries'
			text: [ :each | each countries size ]
			width: 100;
		column: '# Institutions'
			text: [ :each | each institutions size ]
			width: 100;
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #requirement }
TParticipationGroupViews >> institutions [
	^ self explicitRequirement
]

{ #category : #requirement }
TParticipationGroupViews >> participations [
	^ self explicitRequirement
]

{ #category : #requirement }
TParticipationGroupViews >> persons [
	^ self explicitRequirement
]

{ #category : #accessing }
TParticipationGroupViews >> personsSorted [
	^ self persons sort: [ :a :b | a surname < b surname ]
]

{ #category : #mondrian }
TParticipationGroupViews >> workshopPersonsGraph: aMondrian [
	| nodes |
	nodes := self workshops , self persons.
	aMondrian nodes
		shape: [ :node | node mondrianNodeElement ];
		with: nodes.
	aMondrian edges connectToAll: #mondrianChildren.
	aMondrian layout
		custom: (GtGraphForceBasedLayout new
				charge: -1000;
				length: 50).
	^ aMondrian
]

{ #category : #mondrian }
TParticipationGroupViews >> workshopPersonsMondrianGraph [
	^ self workshopPersonsGraph:GtMondrian new
]

{ #category : #requirement }
TParticipationGroupViews >> workshops [
	^ self explicitRequirement
]
