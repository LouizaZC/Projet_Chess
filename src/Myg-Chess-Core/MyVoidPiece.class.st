Class {
	#name : 'MyVoidPiece',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyVoidPiece >> isVoidPiece [ 
	^ true.
	
]

{ #category : 'rendering' }
MyVoidPiece >> renderPieceOn: aSquare [
	^ aSquare color isBlack 
		ifTrue: ['x']
		ifFalse: [ 'z' ]
]

{ #category : 'rendering' }
MyVoidPiece >> targetSquaresLegal: aBoolean [ 
		^ #()
]

{ #category : 'accessing' }
MyVoidPiece >> voidColor [
	^ Color transparent
]
