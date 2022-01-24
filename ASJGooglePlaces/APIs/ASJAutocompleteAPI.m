//
// ASJAutocompleteAPI.m
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

#import "ASJAutocompleteAPI.h"

@interface ASJAutocompleteAPI ()

@property (copy, nonatomic) NSString *query;
@property (copy) AutocompleteBlock completion;
@property (readonly, weak, nonatomic) NSURL *autocompleteURL;

@end

@implementation ASJAutocompleteAPI

#pragma mark - Public

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userLocation = kCLLocationCoordinate2DInvalid;
    }
    return self;
}

- (void)autocompleteForQuery:(NSString *)query completion:(AutocompleteBlock)completion
{
  _query = query;
  _completion = completion;
  
  if (query.length >= _minimumQueryLength) {
    [self executeGooglePlacesRequest];
  }
}

#pragma mark - Private

- (void)executeGooglePlacesRequest
{
  [self executeRequestForURL:self.autocompleteURL completion:^(ASJResponseStatusCode statusCode, NSDictionary *response, NSError *error)
   {
     if (_completion)
     {
       NSArray *places = [ASJPlace placesForResponse:response];
       _completion(statusCode, places, error);
     }
   }];
}

- (NSURL *)autocompleteURL
{
    NSString *relativePath = [NSString stringWithFormat:@"%@?input=%@&key=%@", k_asj_AutocompleteSubURL, _query, self.apiKey];
    if (CLLocationCoordinate2DIsValid(_userLocation)) {
        relativePath = [relativePath stringByAppendingFormat:@"&location=%f,%f", _userLocation.latitude, _userLocation.longitude];
    }
    relativePath = [relativePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:relativePath relativeToURL:self.baseURL];
}

@end
