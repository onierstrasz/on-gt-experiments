"
I collect various examples that were mined during the IMAD project.

Caveat: some of the APIs have changed so a few examples are broken.
"
Class {
	#name : #UsefulExamplesFromIMAD,
	#superclass : #Object,
	#category : #'ONGtExperiments-IMAD'
}

{ #category : #accessing }
UsefulExamplesFromIMAD >> allPragmas [
	<gtExample>
	<return: #Set>
	^ (CompiledMethod allInstances
		flatCollect: [ :m | m pragmas collect: #selector ]) asSet
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> attachGtDocToModel [
	<gtExample>
	<return: #VariableNotDeclared>
	| dict doc |
	dict := Dictionary new.
	dict at: #name put: 'Homer'.
	doc := GtDocument new.
	doc text: (dict at: #name).
	doc
		when: GtDocumentUpdateRequestedAnnouncement
		do: [ dict at: #name put: doc text asString ].	"GtInspector openOn: doc."
	doc text: 'Madge'.
	doc mayRequestDocumentUpdate.
	self assert: (dict at: #name) equals: 'Madge'.
	^ doc
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> autofitElementToContainer [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: BlLinearLayout new;
		background: Color paleBlue;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: (BlElement new
				background: Color paleRed;
				layout: BlLinearLayout new;
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				addChild: (BlTextElement new text: 'something' asRopedText))
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> boxWithToolTip [
	<gtExample>
	<return: #BlElement>
	| box tooltip |
	box := BlElement new
			geometry: (BlRectangle cornerRadius: 10);
			size: 50 @ 50;
			background: Color green;
			yourself.
	tooltip := BrLabel new
			aptitude: BrGlamorousLabelAptitude new glamorousRegularFontAndSize;
			padding: (BlInsets all: 5);
			alignCenter;
			text: 'woohoo' asRopedText;
			yourself.
	box aptitude: (BrGlamorousWithTooltipAptitude2 content: tooltip).
	^ box
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> boxWithWrappedToolTip [
	<gtExample>
	<return: #BlElement>
	| box tooltipLook |
	box := BlElement new
			geometry: (BlRectangle cornerRadius: 10);
			size: 20 @ 20;
			background: Color blue;
			yourself.
	tooltipLook := BrGlamorousWithTooltipAptitude2 content: self wrappedTooltip.
	box aptitude: tooltipLook.
	^ box
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> brokenBezier [
	"Adapted from BlBezierElementExamples"

	<gtExample>
	<return: #BlElement>
	| redCurve attachFrom attachTo viaAttach fromLine toLine |
	redCurve := BlBezierElementExamples new redCurve.

	attachFrom := BlGeometryElementExamples new attachPoint.
	attachFrom relocate: 10 @ 160.

	viaAttach := BlGeometryElementExamples new attachPoint.
	viaAttach relocate: 160 @ 160.	"viaAttach relocate: 160 @ 10."

	attachTo := BlGeometryElementExamples new attachPoint.
	attachTo relocate: 310 @ 160.

	fromLine := BlBezierElementExamples new greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: viaAttach).

	toLine := BlBezierElementExamples new greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: viaAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).

	redCurve fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redCurve viaAnchor: (BlElementCenterAnchor element: viaAttach).
	redCurve toAnchor: (BlElementCenterAnchor element: attachTo).

	^ BlBezierElementExamples new container
		addChildren: {redCurve.
				attachFrom.
				viaAttach.
				attachTo.
				fromLine.
				toLine}
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> brokenParabolla [
	"Curvature 0 makes the curve disappear"

	<gtExample>
	<return: #BlElement>
	| aPrabolla attachFrom attachTo |
	aPrabolla := BlParabollaArcElementExamples new redArcWithToHead
			curvature: 0;
			yourself.
	attachFrom := BlSigmoidElementExamples new attachPoint.
	attachFrom relocate: 100 @ 100.
	attachTo := BlSigmoidElementExamples new attachPoint.
	attachTo relocate: 300 @ 100.
	aPrabolla fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aPrabolla toAnchor: (BlElementCenterAnchor element: attachTo).
	^ BlSigmoidElementExamples new container
		addChildren: {aPrabolla.
				attachFrom.
				attachTo}
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> brokenSigmoid [
	"If the from and to anchors have the same x or y position, the sigmoid is not displayed!
	Adapted from BlSigmoidElementExamples>>#sigmoidBendingMiddlePoint"

	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := BlSigmoidElementExamples new newSigmoid.
	aSigmoid bendingPoint: 0.5.
	aSigmoid sharpness: 1.0.

	attachFrom := BlSigmoidElementExamples new attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := BlSigmoidElementExamples new attachPoint.
	attachTo relocate: 300 @ 100.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ BlSigmoidElementExamples new container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> buildDifferentKindsOfTabs [
	<gtExample>
	<return: #VariableNotDeclared>
	| tabs |
	"Sources:
	BrExamplesShowroom>>#glamorousTabs
	"
	tabs := BrTabGroup new.
	tabs aptitude: BrGlamorousTabGroupAptitude new.

	tabs
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Text';
				stencil: [ GtDocument new text: 'Sample text' ]).

	tabs
		addTab: (BrTab new
				look: BrGlamorousTabAptitude new;
				label: 'BlueBox';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 300 ];
						margin: (BlInsets all: 10);
						background: (Color blue alpha: 0.2) ]).

	tabs
		addTab: (BrTab new
				look: BrGlamorousTabAptitude new;
				label: 'Simpsons';
				stencil: [ (self simpsons gtItemsFor: GtPhlowEmptyView new) asElementDo: [ :e | e ] ]).


	^ tabs
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> buttonWithActions [
	"Example by TG"

	<gtExample>
	<return: #BrButton>
	^ BrButton new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 7);
		icon: BrGlamorousIcons hamburger asElement;
		aptitude: BrGlamorousButtonWithIconAptitude
				+ (BrGlamorousWithDropdownAptitude new
						stencil: [ | aList |
							aList := BrGlamorousSimpleContextMenuContent new.
							aList
								items: {'Action 1' -> [ 'action 1' inspect ].
										'Action 2' -> [ self openTextInOwnWindow: 'action 2' ].
										'Action 3' -> [ self openTextInOwnWindow: 'action 3' ]}.
							BrAnchoredElement new
								look: (BrGlamorousDropdownAptitude new
										handle: (BrButton new
												icon: BrGlamorousIcons hamburger asElement;
												look: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude);
										content: (aList
												padding: (BlInsets all: 5);
												vFitContent;
												hExact: 200)) ]);
		relocate: 200 @ 100
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> buttonWithColoredBackgroundAndForeground [
	<gtExample>
	<return: #BrButton>
	| look |
	look := BrGlamorousButtonLabelAptitude new
			selectedColor: Color white;
			bold;
			yourself.
	look remove: look children last.
	look
		add: (BrInteractiveCommonAptitude new
				default: [ look foreground: Color white ];
				hovered: [ look foreground: BrGlamorousColors hoveredButtonTextColor ];
				pressed: [ look foreground: BrGlamorousColors pressedButtonTextColor ];
				disabled: [ look foreground: BrGlamorousColors disabledButtonTextColor ]).
	^ BrButton new
		label: 'a Button';
		aptitude: look + (BrGlamorousButtonExteriorAptitude new backgroundPaint: Color blue)
				+ BrGlamorousButtonRectangularAptitude new
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> buttonWithThreeStates [
	<gtExample>
	<return: #BrButton>
	| tooltip state offLook onLook negatedLook tooltipLook |
	tooltip := 'Switch on'.
	tooltipLook := BrGlamorousWithTooltipAptitude2
			content: [ BrLabel new
					look: BrGlamorousLabelAptitude new glamorousRegularFontAndSize;
					padding: (BlInsets all: 5);
					alignCenter;
					text: tooltip asRopedText;
					yourself ].
	state := 'off'.	"'off', 'on' or 'negated'"
	offLook := BrGlamorousButtonWithLabelAptitude + tooltipLook.
	onLook := (BrGlamorousButtonLabelAptitude new
			bold;
			yourself) + BrGlamorousButtonExteriorAptitude new
			+ BrGlamorousButtonRectangularAptitude new + tooltipLook.
	negatedLook := (BrGlamorousButtonLabelAptitude new
			bold;
			yourself)
			+ (BrGlamorousButtonExteriorAptitude new backgroundPaint: Color pink)
			+ BrGlamorousButtonRectangularAptitude new + tooltipLook.
	^ BrButton new
		aptitude: offLook;
		label: 'StatefulButton';
		action: [ :e | 
			state = 'off'
				ifTrue: [ state := 'on'.
					tooltip := 'Negate'.
					e aptitude: onLook ]
				ifFalse: [ state = 'on'
						ifTrue: [ state := 'negated'.
							tooltip := 'Switch off'.
							e aptitude: negatedLook ]
						ifFalse: [ state = 'negated'
								ifTrue: [ state := 'off'.
									tooltip := 'Switch on'.
									e aptitude: offLook ] ] ] ]
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> cardTagger [
	"Shows how a tagger looks with many tags"

	<gtExample>
	<return: #VariableNotDeclared>
	| deck card tagger |
	deck := CardDeck new.
	card := Card new.
	deck addCard: card.
	(' ' split: (Boolean comment copyWithRegex: '[^\w ]' matchesReplacedWith: ''))
		do: [ :word | card addTag: word ].
	tagger := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
	tagger addChild: card buildTagHeader.
	card announcer
		when: TagsUpdated
		do: [ tagger removeChildren.
			tagger addChild: card buildTagHeader ].
	^ tagger
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> createPlayGroundWithSnippets [
	<gtExample>
	<return: #VariableNotDeclared>
	| snippets playbook |
	snippets := {'3+4'.
			'42'}.
	playbook := GtPlayBook newWithCodeSnippetContent: snippets first.
	snippets allButFirst
		do: [ :el | playbook pages first addSnippet: (GtCoderSnippet new sourceCode: el) ].	"GtPlayground openOn: playbook."
	^ playbook
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> dropdownOnRightClick [
	"See: BrDropdownExamples>>#coloredDropdown"

	<gtExample>
	<return: #BrButton>
	^ BrButton new
		label: '';
		aptitude: BrGlamorousButtonWithLabelAptitude
				+ (BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: {'Change to blue' -> [ :e | e background: Color blue ].
										'Change to red' -> [ :e | e background: Color red ].
										'Change to green' -> [ :e | e background: Color green ]};
								yourself ]);
		yourself
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> dropdownWithChangingContent [
	<gtExample>
	<return: #GtPhlowDropdownAction>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
			icon: BrGlamorousIcons menu;
			content: [ | menu |
				menu := BlElement new
						layout: BlLinearLayout vertical;
						constraintsDo: [ :c | 
							c padding: (BlInsets all: 5).
							c vertical fitContent.
							c horizontal exact: 100 ].
				menu
					addChild: (BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude;
							label: 'Do it!';
							action: [ :button | 
								menu removeChildren.
								menu
									addChild: (BlTextElement new text: ('Done!' asRopedText fontSize: 12)) ]).
				menu ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	^ anAction
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> elementHandlingClickEvents [
	"I show how to react to different kinds of click events."

	<gtExample>
	<return: #BlElement>
	| clickElt |
	clickElt := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: 300 ];
			margin: (BlInsets all: 10);
			background: (Color blue alpha: 0.2).
	clickElt
		aptitude: (BrStyleCommonAptitude new
				default: [ :elt | elt border: (BlBorder paint: Color transparent width: 1) ];
				hovered: [ :elt | elt border: (BlBorder paint: Color red width: 1) ])
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new items: {'Click' -> [ :e |  ]} ])
						usePrimaryMouseButton;
						modifiersMatcher: #isEmpty;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new items: {'Ctrl-click' -> [ :e |  ]} ])
						usePrimaryMouseButton;
						modifiersMatcher: #isCtrl;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new items: {'Alt-click' -> [ :e |  ]} ])
						usePrimaryMouseButton;
						modifiersMatcher: #isAlt;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new items: {'Cmd-click' -> [ :e |  ]} ])
						usePrimaryMouseButton;
						modifiersMatcher: #isCmd;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new items: {'Right-click' -> [ :e |  ]} ])
						useSecondaryMouseButton;
						modifiersMatcher: #isEmpty;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: {'Ctrl-right-click' -> [ :e |  ]} ])
						useSecondaryMouseButton;
						modifiersMatcher: #isCtrl;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: {'Alt-right-click' -> [ :e |  ]} ])
						useSecondaryMouseButton;
						modifiersMatcher: #isAlt;
						yourself)
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: {'Cmd-right-click' -> [ :e |  ]} ])
						useSecondaryMouseButton;
						modifiersMatcher: #isCmd;
						yourself).
	^ clickElt
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> examplesExplorerForPackage [
	<gtExample>
	<return: #MessageNotUnderstood>
	| baseline repo |
	baseline := BaselineOfIMAD.
	repo := 'github.com/onierstrasz/ASA-GtExperiments/src'.
	^ (GtRlSystemExamplesExplorer
		forProject: (GtRlDependenciesModelBuilder new
				buildProjectFromBaselineClass: baseline
				withRepositoryDescription: repo)) repositoryExplorers at: 1
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> filterToExampleGroup [
	<gtExample>
	<return: #GtExplicitExampleGroup>
	^ #printString gtReferences gtExamples
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> findAllTodosInAPackage [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ #todo: gtPragmas & 'IMAD-Card' gtPackageMatches
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> findExamplesOfAClass [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ BrTab gtReferences & #gtExample gtPragmas
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> graphWithoutClipping [
	"Shows how to have a graph with draggable nodes that can use the full available area instead of a clipped area.
	AC: Every element has a clipChildren property. In BlElement the clipping area is the same as the geometry of the element. To not have that behaviour the view could be placed in a parent that matches parent and uses clipChildren: false. It worked like that initially in mondrian, but we had some problems as clipping children can be a very expensive operation (https://github.com/feenkcom/gtoolkit/issues/520).
	Fixed 2020-07-22 with ML. Need to also set clipChildren false on the pannable.
	"

	<gtExample>
	<return: #BlPannableElement>
	| root elts pannable |
	elts := Dictionary new.
	root := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].	"Using fitContent instead of matchParent will zoom the graph to maximum size."
	{'A'.
		'B'.
		'C'}
		do: [ :each | 
			| elt |
			elt := self rectangleWithText: each.
			elt graph beNode.
			elt addEventHandler: BlPullHandler new.
			elts at: each put: elt.
			root addChild: elt ].
	{'A' -> 'B'.
		'A' -> 'C'}
		do: [ :rel | 
			| source target line |
			source := elts at: rel key.
			target := elts at: rel value.
			source graph connectTo: target.
			line := BlLineElement new
					zIndex: -1;
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 5).
			line
				fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: target from: source);
				toAnchor: (BlNearestPositionBoundsAnchor nearestTo: source from: target).
			root addChild: line ].
	root layout: (BlOnceLayout new layout: GtGradCircleLayout new).	"GtGradVerticalTreeLayout"
	root clipChildren: false.
	pannable := root asPannableElement.
	pannable zoomableElement clipChildren: false.
	^ pannable
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> gtToolsMenu [
	"See GtWorldElement>>#newSubSpaceButton and GtToolsMenu"

	<gtExample>
	<return: #MessageNotUnderstood>
	| menu |
	"menu := GtToolsMenu new."
	menu := BlElement new.	"initialize"
	menu layout: BlFlowLayout new.
	menu
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal exact: 420 ].
	menu padding: (BlInsets top: 10 bottom: 10).

	menu removeChildren.

	menu
		addChild: (GtHomeToolsSection new newPlaygroundButtonStencil smallIcon create
				size: 100 @ 100).
	menu
		addChild: (GtHomeToolsSection new newCoderButtonStencil smallIcon create size: 100 @ 100).
	menu
		addChild: (GtHomeToolsSection new newGitButtonStencil smallIcon create size: 100 @ 100).
	menu
		addChild: (GtHomeToolsSection new newMonitorButtonStencil smallIcon create size: 100 @ 100).
	menu
		addChild: (GtHomeToolsSection new newExamplesButtonStencil smallIcon create
				size: 100 @ 100).
	menu
		addChild: (GtHomeToolsSection new newTranscriptButtonStencil smallIcon create
				size: 100 @ 100).
	menu
		addChild: (GtHomeToolsSection new newMorphicWorldButtonStencil smallIcon create
				size: 100 @ 100).

	menu
		addChild: (BlElement new
				layout: (BlLinearLayout horizontal cellSpacing: 10);
				margin: (BlInsets
						top: 25
						left: 10
						bottom: 5
						right: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ];
				addChildren: {BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude new;
							label: 'Save';
							hMatchParent;
							action: [ :aButton | aButton space universe snapshot: true andQuit: false ].
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude new;
							label: 'Quit';
							hMatchParent;
							action: [ :aButton | aButton space universe snapshot: false andQuit: true ]}).

	^ menu
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> hamburgerDropdown [
	<gtExample>
	<return: #BrButton>
	| subSpaceDropdown |
	subSpaceDropdown := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude
					+ (BrGlamorousWithDropdownAptitude
							handle: [ BrButton new
									aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousWithLabelTooltipAptitude
											- BrGlamorousButtonExteriorAptitude;
									icon: BrGlamorousIcons hamburger asElement;
									label: 'Menu' ]
							content: [ self gtToolsMenu ]);
			icon: BrGlamorousIcons hamburger asElement;
			label: 'Menu';
			yourself.
	^ subSpaceDropdown
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> hamburgerWithIconLook [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Menu'
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> hamburgerWithLabelLook [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Menu'
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> johnDoeContact [
	<gtExample>
	<return: #GtABContact>
	^ GtABAddressBookExample new johnDoeContact
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> lineWithHoverAndContextMenu [
	<gtExample>
	<return: #BlLineElement>
	| line |
	line := BlLineElement new
			fromAnchor: (BlAbsolutePositionAnchor position: 75 @ 140);
			toAnchor: (BlAbsolutePositionAnchor position: 200 @ 240);
			border: (BlBorder paint: Color blue width: 4);
			yourself.
	line
		aptitude: (BrStyleCommonAptitude new
				default: [ :elt | elt border: (BlBorder paint: Color gray width: 4) ];
				hovered: [ :elt | elt border: (BlBorder paint: Color red width: 4) ])
				+ (BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: {'Change to blue' -> [ line border: (BlBorder paint: Color blue width: 4) ].
										'Change to red'
											-> [ line border: (BlBorder paint: Color red width: 4) ].
										'Change to green'
											-> [ line border: (BlBorder paint: Color green width: 4) ]};
								yourself ]).
	^ line
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> linesDontRespondToEevents [
	"Why can I pull the box but not the line?"

	<gtExample>
	<return: #BlElement>
	| container line box |
	container := BlElement new
			background: Color white;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.
	box := BlElement new
			size: 100 @ 100;
			background: (Color gray alpha: 0.1);
			addEventHandler: BlPullHandler new;
			yourself.
	line := BlLineElement new
			fromAnchor: (BlAbsolutePositionAnchor position: 75 @ 140);
			toAnchor: (BlAbsolutePositionAnchor position: 200 @ 240);
			border: (BlBorder paint: Color blue width: 4);
			addEventHandler: BlPullHandler new;
			yourself.
	container
		addChildren: {line.
				box}.
	^ container
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> lookSubtraction [
	"this simply means that we are not taking BrGlamorousButtonExteriorAptitude into account in this case, and we will get no border"

	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Menu'
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> menuFor: aString [
	^ BrGlamorousSimpleContextMenuContent new
		items: {(aString -> [ :e |  ])};
		yourself
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> mondrianWithButton [
	<gtExample>
	<todo: 'make the button add nodes to the mondrian graph'>
	<return: #BlElement>
	| mondrian container |
	mondrian := GtMondrian new.
	mondrian nodes
		shape: [ :x | 
			BlElement new
				size: 50 @ 50;
				background: Color black ];
		with: (1 to: 15).
	mondrian edges connectFrom: [ :x | x // 2 ].
	mondrian layout tree.
	container := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.
	container
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons add;
				label: 'Menu').
	container addChild: mondrian root.
	^ container
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> nestedMenuTOFIX [
	<todo: 'This is just a skeleton. How to get the nesting?'>
	<gtExample>
	<return: #BlElement>
	| main nested |
	nested := BlTextElement new text: 'nested' asRopedText.
	nested
		aptitude: (BrGlamorousWithContextMenuAptitude
				content: [ BrGlamorousSimpleContextMenuContent new
						items: {'Change to blue' -> [ :e | e background: Color blue ].
								'Change to red' -> [ :e | e background: Color red ].
								'Change to green' -> [ :e | e background: Color green ]};
						yourself ]);
		yourself.
	main := BlElement new
			background: Color red;
			yourself.
	main
		aptitude: (BrGlamorousWithContextMenuAptitude
				content: [ BrGlamorousSimpleContextMenuContent new
						items: {nested -> [  ]};
						yourself ]);
		yourself.
	^ main
]

{ #category : #utilities }
UsefulExamplesFromIMAD >> openTextInOwnWindow: aString [
	"UsefulExamples new openTextInOwnWindow: 'hello'"
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 500 @ 50.
	aSpace addChild: (BlTextElement new text: aString asRopedText). "NB: Could be any kind of BlElement"
	aSpace withHalos.
	aSpace show
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> paneWithTabs [
	<gtExample>
	<return: #VariableNotDeclared>
	| contentPane label |
	contentPane := BlElement new.
	contentPane layout: BlLinearLayout vertical.
	contentPane
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	label := BrLabel new
			margin: (BlInsets left: 10);
			aptitude: (BrGlamorousLabelAptitude new bold glamorousRegularFont fontSize: 20);
			text: 'Woohoo'.
	contentPane addChild: label.
	contentPane addChild: self buildDifferentKindsOfTabs.
	^ contentPane
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> rectangleWithText [
	<gtExample>
	<return: #BlElement>
	^ self rectangleWithText: 'woohoo'
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> rectangleWithText: aString [
	^ BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder paint: Color black);
		geometry: BlRectangle new;
		size: 60 @ 40;
		addChild:
			(BlTextElement new
				text: (aString asRopedText fontSize: 12);
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				yourself);
		yourself
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> scrollableMethodCoder [
	<gtExample>
	<return: #VariableNotDeclared>
	^ (GtMethodCoder
		forClass: CardDeckExamples
		source: CardDeckExamples new facultyDoodleDomain generateStorageMethodString)
		asElement asScrollableElement	"expanded: true;"
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> searchFilterExamples [
	<gtExample>
	<return: #'GtSearchMethodReferencesFilterExamples class'>
	^ GtSearchMethodReferencesFilterExamples
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> simpsons [
	^ OrderedCollection with: 'Homer' with: 'Marge' with: 'Lisa' with: 'Bart' with: 'Maggie'
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> textWithMenuAtRight [
	"Adapted from BlLinearLayoutUsageExamples>>#twoChildrenOnOppositeSidesWithSpan"

	<gtExample>
	<return: #BlElement>
	| parent left span right |
	parent := BlElement new.
	parent layout: BlLinearLayout horizontal.
	parent
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

	left := BrLabel new
			margin: (BlInsets left: 10);
			aptitude: (BrGlamorousLabelAptitude new bold glamorousRegularFont fontSize: 20);
			text: 'Woohoo!'.

	span := BlElement new.
	span
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	right := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons hamburger asElement;
			label: 'Menu'.

	parent
		addChildren: {left.
				span.
				right}.

	^ parent
]

{ #category : #accessing }
UsefulExamplesFromIMAD >> wrappedTooltip [
	"Note that the exact width has to be set on the BrEditor and not the container. The problem is that the look (BrTooltipBottomCenterAptitude) will override the horizontal constaint on the content anyway."

	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 5).
			c vertical fitContent.
			c horizontal fitContent ];
		addChild: (BrEditor new
				aptitude: BrGlamorousRegularEditorAptitude new;
				text: Boolean comment;
				hExact: 200;
				yourself)
]
