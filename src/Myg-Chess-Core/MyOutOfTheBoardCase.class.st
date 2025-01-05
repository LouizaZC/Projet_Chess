Class {
	#name : 'MyOutOfTheBoardCase',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyOutOfTheBoardCase >> contents [
	 ^self
]

{ #category : 'instance creation' }
MyOutOfTheBoardCase >> down [

	^ self
]

{ #category : 'instance creation' }
MyOutOfTheBoardCase >> file [

	^ 0
]

{ #category : 'testing' }
MyOutOfTheBoardCase >> hasPiece [ 

	^ false
]

{ #category : 'highlighting' }
MyOutOfTheBoardCase >> highlightTarget [ 
	"we cannot highlight a target out of the board"

]

{ #category : 'instance creation' }
MyOutOfTheBoardCase >> isOutOftheBoard [

	^ true
]

{ #category : 'instance creation' }
MyOutOfTheBoardCase >> left [

	^ self
]

{ #category : 'accessing' }
MyOutOfTheBoardCase >> name [
	^ 'out of the board'
]

{ #category : 'instance creation' }
MyOutOfTheBoardCase >> right [

	^ self
]

{ #category : 'testing' }
MyOutOfTheBoardCase >> targetSquaresLegal: aBoolean [ 
    ^ #()
]

{ #category : 'highlighting' }
MyOutOfTheBoardCase >> unhighlightTarget [ 
	"we cannot unhighlight a target out of the board"

]

{ #category : 'instance creation' }
MyOutOfTheBoardCase >> up [

	^ self
]
