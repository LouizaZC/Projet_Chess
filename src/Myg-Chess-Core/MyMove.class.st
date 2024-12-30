Class {
	#name : 'MyMove',
	#superclass : 'Object',
	#instVars : [
		'piece',
		'fromSquare',
		'toSquare'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyMove >> fromSquare [ 
	^ fromSquare

]

{ #category : 'accessing' }
MyMove >> fromSquare: aSquare [ 
	fromSquare := aSquare 
]

{ #category : 'accessing' }
MyMove >> piece [ 
	^ piece

]

{ #category : 'accessing' }
MyMove >> piece: aPiece [ 
	piece := aPiece 

]

{ #category : 'accessing' }
MyMove >> toSquare [ 
	^ toSquare

]

{ #category : 'accessing' }
MyMove >> toSquare: aSquare [ 
	toSquare := aSquare 

]
