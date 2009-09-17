// RXBlendColourPicker.h
// Created by Rob Rix on 2009-09-17
// Copyright 2009 Monochrome Industries

@interface RXBlendColourPicker : NSColorPicker {
	IBOutlet NSView *view;
	NSColor *fromColour, *toColour;
	CGFloat fraction;
}

@property (nonatomic, retain) NSColor *fromColour;
@property (nonatomic, retain) NSColor *toColour;

@property (nonatomic) CGFloat fraction;

@end