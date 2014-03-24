//
//  RssParser.m
//  RssReader
//
//  Created by Nikolay Shatilo on 18.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "RssParser.h"


typedef enum { StateTypeNone, StateTypeItem, StateTypeTitle, StateTypeLink } StateType;

@interface RssParser ()

@property (nonatomic, strong) NewsItem *newsItem;
@property (nonatomic, strong) NSMutableString *title;
@property (nonatomic, strong) NSMutableString *link;

@property StateType stateType;

@end

@implementation RssParser

- (id)initWithXMLParser:(NSXMLParser *)aXMLParser
{
    self = [super init];
    
    if(self) {
        _XMLParser = aXMLParser;
        _XMLParser.delegate = self;
    }
    
    return self;
}

- (void)start
{
    [self.XMLParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"]) {
        self.stateType = StateTypeItem;
        self.newsItem = [[NewsItem alloc] init];
    } else if ([elementName isEqualToString:@"title"] && self.stateType == StateTypeItem) {
        self.stateType = StateTypeTitle;
        self.title = [[NSMutableString alloc] init];
    } else if([elementName isEqualToString:@"link"] && self.stateType == StateTypeItem) {
        self.stateType = StateTypeLink;
        self.link = [[NSMutableString alloc] init];
    }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"item"]) {
        [self.delegate didNewsItemUpload:self.newsItem];
        
        self.stateType = StateTypeNone;
        self.newsItem = nil;
    } else if ([elementName isEqualToString:@"title"] && self.stateType == StateTypeTitle) {
        self.stateType = StateTypeItem;
        self.newsItem.title = self.title;
        self.title = nil;
    } else if ([elementName isEqualToString:@"link"] && self.stateType == StateTypeLink) {
        self.stateType = StateTypeItem;
        self.newsItem.link = [NSURL URLWithString:self.link];
        self.link = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    switch (self.stateType) {
        case StateTypeTitle:
            [self.title appendString:string];
            break;
        case StateTypeLink:
            [self.link appendString: string];
            break;
        default:
            break;
    }
   
}

@end
