Class {
	#name : 'MyVoidPiece',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyVoidPiece >> hasPiece [ 
	^ false
]

{ #category : 'accessing' }
MyVoidPiece >> id [ 
	^ 'void'
]

{ #category : 'testing' }
MyVoidPiece >> isVoidPiece [ 
	^ true.
]

{ #category : 'path commands' }
MyVoidPiece >> moveTo: aSquare [
	^ self error: 'We cannot move a void piece'
]

{ #category : 'testing' }
MyVoidPiece >> renderPieceOn: aSquare [
	^ aSquare color isBlack
        ifTrue: [ 'x' ]
        ifFalse: [ 'z' ]
]

{ #category : 'rendering' }
MyVoidPiece >> targetSquaresLegal: aBoolean [ 
		^ #()
]

{ #category : 'as yet unclassified' }
MyVoidPiece >> voidPieceColor [
	^ Color transparent
]
