//
// ASJPlaceIDAPI.m
//
// Copyright (c) 2014-2016 Sudeep Jaiswal
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ASJPlaceIDAPI.h"
#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>

@interface ASJPlaceIDAPI ()

@property (copy, nonatomic) NSString *placeName;
@property (copy) PlaceIDBlock completion;
@property (readonly, weak, nonatomic) NSURL *placeIDURL;

@end

@implementation ASJPlaceIDAPI

#pragma mark - Public

- (void)placeIDForPlace:(NSString *)place completion:(PlaceIDBlock)completion
{
    _placeName = place;
    _completion = completion;
    [self executeGooglePlacesRequest];
}

#pragma mark - Private

- (void)executeGooglePlacesRequest
{
    [self executeRequestForURL:self.placeIDURL completion:^(ASJResponseStatusCode statusCode, NSDictionary *response, NSError *error)
     {
        if (!self->_completion) {
            return;
        }
        
        NSArray *results = response[@"results"];
        if (!results.count)
        {
            self->_completion(statusCode, nil, error);
            return;
        }
        
        NSDictionary *topResult = results[0];
        NSString *placeID = topResult[@"place_id"];
        self->_completion(statusCode, placeID, error);
    }];
}

- (NSURL *)placeIDURL
{
    NSString *relativePath = [NSString stringWithFormat:@"%@?query=%@&key=%@", k_asj_PlaceIDSubURL, _placeName, self.apiKey];
    relativePath = [relativePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:relativePath relativeToURL:self.baseURL];
}

@end
