Class {
	#name : #BellairsParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'workshopTitle',
		'organizerRole',
		'participantRole',
		'person',
		'personSimple',
		'ignore',
		'bellairsLine'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #grammar }
BellairsParser >> bellairsLine [
	^ (workshopTitle / organizerRole / participantRole / person / personSimple
		/ ignore) end
]

{ #category : #grammar }
BellairsParser >> ignore [
	^ #any asPParser star ==> [ :nodes | nil ]
]

{ #category : #grammar }
BellairsParser >> organizerRole [
	^ '<h1>Organizers</h1>' asPParser trim
		==> [ :nodes "role := 'Organizer'." | nil ]
]

{ #category : #grammar }
BellairsParser >> participantRole [
	^ '<h1>Confirmed Participants</h1>' asPParser trim
		==> [ :nodes "role := 'Participant'." | nil ]
]

{ #category : #grammar }
BellairsParser >> person [
	^ ('<!--' asPParser trim optional
		, '<li><a target="_committee" href="' asPParser trim
		, ('https://' asPParser / 'http://' asPParser , $" asPParser negate plus) flatten
		, '">' asPParser , $< asPParser negate plus flatten
		, ('</a>' asPParser , $, asPParser optional) trim
		, $, asPParser negate plus flatten , ',' asPParser trim
		, $< asPParser negate plus flatten
		, ('</li>' asPParser trim , '-->' asPParser trim optional))
		==> [ :nodes | 
			{'url' -> nodes third.
				'name' -> nodes fifth.
				'institution' -> nodes seventh.
				'country' -> nodes ninth} asDictionary ]
]

{ #category : #grammar }
BellairsParser >> personSimple [
	^ ('<li><a' asPParser not trim , '<li>' asPParser trim
		, $, asPParser negate plus flatten , $, asPParser trim
		, $, asPParser negate plus flatten , $, asPParser trim
		, $< asPParser negate plus flatten , '</li>' asPParser)
		==> [ :nodes | 
			{'name' -> nodes third.
				'institution' -> nodes fifth.
				'country' -> nodes seventh} asDictionary ]
]

{ #category : #accessing }
BellairsParser >> start [
	^ bellairsLine
]

{ #category : #grammar }
BellairsParser >> workshopTitle [
	^ ('<!-- all content &copy; ' asPParser
		, (' -->' asPParser not , #any asPParser) star flatten , ' -->' asPParser)
		==> [ :nodes "workshop := nodes second trim." | nil ]
]
