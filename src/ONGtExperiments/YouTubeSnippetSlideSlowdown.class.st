"
I demonstrate the slowdown in creating and inspecting a slideshow containing a transient database page with YouTube snippets.
"
Class {
	#name : #YouTubeSnippetSlideSlowdown,
	#superclass : #PrioritySlideshow,
	#category : #'ONGtExperiments-YouTubeSlowdown'
}

{ #category : #accessing }
YouTubeSnippetSlideSlowdown >> slidePriorities [
	<gtExample>
	<return: #Array>
	^ #(youTubeSnippetIssue:)
]

{ #category : #accessing }
YouTubeSnippetSlideSlowdown >> youTubeSnippetIssue: aSlide [
	<gtSlide>
	<text: 'This slide demos the slow loading issue.'>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self database pageNamed: 'YouTube snippet issue')
]

{ #category : #accessing }
YouTubeSnippetSlideSlowdown >> youTubeSnippetPage [
	"NB: loading the YouTube video snippet is very slow!"

	<lePage>
	<gtExample>
	<noTest>
	
	^ (LePage named: 'YouTube snippet issue')
	addSnippet: (LeTextSnippet new
			string: 'Adding  a YouTube snippet to a transient database page within a slide makes it very slow to load. Adding more snippets slows it more.';
			yourself);
	addSnippet: (LeYoutubeReferenceSnippet new
			urlString: 'https://youtu.be/gd8Wa1rSK_M?start=165&end=240';
			yourself);
	addSnippet: (LeYoutubeReferenceSnippet new
			urlString: 'https://www.youtube.com/watch?v=E3eDDSPCf7c';
			yourself);
	addSnippet: (LeYoutubeReferenceSnippet new
			urlString: 'https://www.youtube.com/watch?v=_ztGZpo9I9E&t=2022s';
			yourself);
	addSnippet: (LeTextSnippet new
			string: '';
			yourself);
	yourself
]
