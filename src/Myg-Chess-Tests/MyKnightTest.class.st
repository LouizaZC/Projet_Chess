Class {
	#name : 'MyKnightTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'accessing' }
MyKnightTest >> method [
 | knight |
	
knight := MyKnight new.
knight color: Color black.
self assert: knight color = Color black
]

{ #category : 'tests' }
MyKnightTest >> testIsBlackKnight [
	"self assert: ((MyKnight new color: Color black) color = Color black)."
	self assert: ((MyKnight black) color = Color black). 
	
"| knight |
	
knight := MyKnight new.
knight color: Color black.
self assert: knight color = Color black "
]

{ #category : 'tests' }
MyKnightTest >> testIsWhiteKnight [
	self assert: ((MyKnight white)color = Color white)
]

{ #category : 'tests' }
MyKnightTest >> testKnightId [
	self assert: MyKnight new id equals: 'N'
]
