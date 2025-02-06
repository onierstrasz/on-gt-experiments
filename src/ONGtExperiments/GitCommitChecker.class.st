"
I return a list of modified GitHub repos for which there are pending commits.
```
GitCommitChecker new modifiedRepos.
```
Sometimes the list needs to be refreshed:
```
GitCommitChecker new refreshedModifiedRepos.
```
"
Class {
	#name : #GitCommitChecker,
	#superclass : #Object,
	#category : #'ONGtExperiments-Utilities'
}

{ #category : #accessing }
GitCommitChecker >> modifiedRepos [
	<gtExample>
	^ (IceRepository gtGitRepositories reject: #isMissing) select: #isModified
]

{ #category : #accessing }
GitCommitChecker >> refreshedModifiedRepos [
	<gtExample>
	^ (self modifiedRepos reject: #isMissing)
		select: [ :r | 
			r hasChanges
				and: [ r refreshDirtyPackages.
					r hasChanges ] ]
]
