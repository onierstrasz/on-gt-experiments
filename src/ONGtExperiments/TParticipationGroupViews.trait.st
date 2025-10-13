Trait {
	#name : #TParticipationGroupViews,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #requirement }
TParticipationGroupViews >> countries [
	^ (self participations collect: #country) copyWithoutDuplicates sorted
]

{ #category : #views }
TParticipationGroupViews >> gtCountriesFor: aView [
	"To do: should a country be a domain entity?"

	<gtView>
	^ aView forward
		title: 'Countries';
		priority: 32;
		object: [ self countries ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : #views }
TParticipationGroupViews >> gtInstitutionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Institutions';
		priority: 30;
		items: [ self institutions sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
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
		items: [ self persons sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
TParticipationGroupViews >> gtWorkshopsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Workshops';
		priority: 10;
		items: [  self workshops sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
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

{ #category : #requirement }
TParticipationGroupViews >> workshops [
	^ self explicitRequirement
]
