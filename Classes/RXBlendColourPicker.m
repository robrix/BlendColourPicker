// RXBlendColourPicker.m
// Created by Rob Rix on 2009-09-17
// Copyright 2009 Monochrome Industries

#import "RXBlendColourPicker.h"

@implementation RXBlendColourPicker

-(id)initWithPickerMask:(NSUInteger)mask colorPanel:(NSColorPanel *)colourPanel {
	if(self = [super initWithPickerMask: mask colorPanel: colourPanel]) {
		fromColour = [NSColor whiteColor];
		toColour = [NSColor blackColor];
		fraction = 0.5;
		
		[self addObserver: self forKeyPath: @"fromColour" options: 0 context: NULL];
		[self addObserver: self forKeyPath: @"toColour" options: 0 context: NULL];
		[self addObserver: self forKeyPath: @"fraction" options: 0 context: NULL];
	}
	return self;
}

-(void)dealloc {
	[self removeObserver: self forKeyPath: @"fromColour"];
	[self removeObserver: self forKeyPath: @"toColour"];
	[self removeObserver: self forKeyPath: @"fraction"];
	
	[fromColour release];
	[toColour release];
	[view release];
	[super dealloc];
}


@synthesize fromColour, toColour, fraction;

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if(object == self) {
		self.colorPanel.color = [fromColour blendedColorWithFraction: fraction ofColor: toColour];
	}
}


// NSColorPickingCustom
-(void)setColor:(NSColor *)color {}


-(NSColorPanelMode)currentMode {
	return NSRGBModeColorPanel;
}

-(BOOL)supportsMode:(NSColorPanelMode)mode {
	return mode == NSRGBModeColorPanel;
}


-(NSView *)provideNewView:(BOOL)isInitialRequest {
	if(isInitialRequest) {
		if(![NSBundle loadNibNamed: @"RXBlendColourPicker" owner: self]) {
			NSLog(@"Couldn’t load RXBlendColourPicker.");
		}
	}
	return view;
}


// NSColorPickingDefault
-(NSString *)buttonToolTip {
	return NSLocalizedString(@"Blend of Two Colors", nil);
}

@end