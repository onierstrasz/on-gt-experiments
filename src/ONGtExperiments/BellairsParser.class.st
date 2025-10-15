"
I am a parser for the web pages of the Bellairs workshop series.

The pages each list the participations of persons from various institutions in the given workshop, in a particularrole (organizer or participant).
I extract this information from each web page, and generate a JSON of dictionaries, each containing  the details of one such participation.
The result is used by the {{gtClass:name=BellairsWorkshopsRegistry}} to create domain entities from the JSON.
"
Class {
	#name : #BellairsParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'workshopTitle',
		'organizerRole',
		'participantRole',
		'participation',
		'participationSimple',
		'ignore',
		'bellairsLine',
		'role',
		'workshop'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #grammar }
BellairsParser >> bellairsLine [
	"A line of input should match one of these rules."

	^ (workshopTitle / organizerRole / participantRole / participation / participationSimple
		/ ignore) end
]

{ #category : #grammar }
BellairsParser >> ignore [
	^ #any asPParser star ==> [ :nodes | nil ]
]

{ #category : #grammar }
BellairsParser >> organizerRole [
	^ '<h1>Organizers</h1>' asPParser trim
		==> [ :nodes | 
			role := 'Organizer'.
			nil ]
]

{ #category : #grammar }
BellairsParser >> participantRole [
	^ '<h1>Confirmed Participants</h1>' asPParser trim
		/ '<h1>Participants</h1>' asPParser trim
		==> [ :nodes | 
			role := 'Participant'.
			nil ]
]

{ #category : #grammar }
BellairsParser >> participation [
	^ ('<!--' asPParser trim optional
		, '<li><a target="_committee" href="' asPParser trim
		, ('https://' asPParser / 'http://' asPParser , $" asPParser negate plus) flatten
		, '">' asPParser , $< asPParser negate plus flatten
		, ('</a>' asPParser , $, asPParser optional) trim
		, $, asPParser negate plus flatten , ',' asPParser trim
		, $< asPParser negate plus flatten
		, ('</li>' asPParser trim , '-->' asPParser trim optional))
		==> [ :nodes | 
			{
				'person' -> nodes fifth.
				'url' -> nodes third.
				'workshop' -> self workshop.
				'role' -> self role.
				'affiliation' -> nodes seventh.
				'country' -> nodes ninth} asDictionary ]
]

{ #category : #grammar }
BellairsParser >> participationSimple [
	^ ('<li><a' asPParser not trim , '<li>' asPParser trim
		, $, asPParser negate plus flatten , $, asPParser trim
		, $, asPParser negate plus flatten , $, asPParser trim
		, $< asPParser negate plus flatten , '</li>' asPParser)
		==> [ :nodes | 
			{'person' -> nodes third.
				'workshop' -> self workshop.
				'role' -> self role.
				'affiliation' -> nodes fifth.
				'country' -> nodes seventh} asDictionary ]
]

{ #category : #accessing }
BellairsParser >> role [
	^ role ifNil: [ 'Unknown' ]
]

{ #category : #accessing }
BellairsParser >> start [
	^ bellairsLine
]

{ #category : #accessing }
BellairsParser >> workshop [
	^ workshop ifNil: [ 'Unknown' ]
]

{ #category : #grammar }
BellairsParser >> workshopTitle [
	^ ('<!-- all content &copy; ' asPParser
		, (' -->' asPParser not , #any asPParser) star flatten , ' -->' asPParser)
		==> [ :nodes | 
			workshop := nodes second trim.
			nil ]
]
