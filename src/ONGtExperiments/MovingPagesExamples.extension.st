Extension { #name : #MovingPagesExamples }

{ #category : #'*ONGtExperiments' }
MovingPagesExamples >> helloWorldSnippetPage [
	<moveablePage>
	<gtExample>
	^ (LePage named: 'A HelloWorld snippet page')
		addSnippet: (HelloWorldSnippet new
				contentString: 'Hello world!';
				yourself);
		yourself
]
