//
// ASJPlaceDetailsAPI.h
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

#import "ASJPlaceDetails.h"
#import "ASJSession.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PlaceDetailsBlock)(ASJResponseStatusCode statusCode, ASJPlaceDetails * _Nullable placeDetails, NSError * _Nullable error);

@interface ASJPlaceDetailsAPI : ASJSession

/**
 *  Fetch place details of a place by its name.
 *
 *  @param place      The place's name.
 *  @param completion A completion block that is called when the API call is complete.
 */
- (void)placeDetailsForPlace:(NSString *)place completion:(PlaceDetailsBlock)completion;

/**
 *  Fetch place details of a place by its unique place ID.
 *
 *  @param placeID    The place's unique ID.
 *  @param completion A completion block that is called when the API call is complete.
 */
- (void)placeDetailsForPlaceID:(NSString *)placeID completion:(PlaceDetailsBlock)completion;

@end

NS_ASSUME_NONNULL_END
