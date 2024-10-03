Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'move'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'initialization' }
MyPawn >> initialize [
        move := true.
		
]

{ #category : 'testing' }
MyPawn >> isBlack [ 
        ^ color = Color black
]

{ #category : 'testing' }
MyPawn >> isMoving: aBoolean [
	move:= aBoolean .

]

{ #category : 'testing' }
MyPawn >> isWhite [ 
        ^ color = Color white
]

{ #category : 'instance creation' }
MyPawn >> move [
	^ move
]

{ #category : 'path commands' }
MyPawn >> moveTo: aCase [ 

	super moveTo: aCase.
	move := false.

]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [
			  s hasPiece not or: [ s contents color ~= color ] ] ]
]

{ #category : 'tests' }
MyPawn >> testIsBlackAndIsWhite [ 
    | blackPawn whitePawn |
    
    blackPawn := MyPawn new: Color black.
    whitePawn := MyPawn new: Color white.
    
    self assert: blackPawn isBlack.
    self assert: whitePawn isWhite.
]
