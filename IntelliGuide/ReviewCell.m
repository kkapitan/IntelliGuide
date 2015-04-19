//
//  ReviewCell.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "ReviewCell.h"

@interface ReviewCell()

@property (weak, nonatomic) IBOutlet UILabel *reviewerName;
@property (weak, nonatomic) IBOutlet UILabel *reviewContent;

@end

@implementation ReviewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReview:(IGReview *)review {
    _review = review;
    _reviewerName.text = review.reviewerName;
    _reviewContent.text = review.content;
}

@end
