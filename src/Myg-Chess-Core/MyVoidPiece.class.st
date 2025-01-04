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

{ #category : 'testing' }
MyVoidPiece >> isVoidPiece [ 
	^ true.
]

{ #category : 'testing' }
MyVoidPiece >> renderPieceOn: aSquare [
	^ nil
]

{ #category : 'rendering' }
MyVoidPiece >> targetSquaresLegal: aBoolean [ 
		^ #()
]

{ #category : 'as yet unclassified' }
MyVoidPiece >> voidPieceColor [
	^ Color transparent
]
