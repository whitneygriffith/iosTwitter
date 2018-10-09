//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Whitney Griffith on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
class TweetCell: UITableViewCell {

    /*user profile picture, username, tweet text, and timestamp*/
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    var tweet: Tweet!{
        
        didSet{
            tweetLabel.text = tweet.text
            username.text = tweet.user!.name
            timestamp.text = tweet.createdAtString
            profilePic.af_setImage(withURL: tweet.photoURL!)
            retweetLabel.text = String(tweet.retweetCount)
            likeLabel.text = String(tweet.favoriteCount!)
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        if tweet.retweeted {
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    let count = tweet.favoriteCount! - 1
                    self.likeLabel.text = String(count)
                }
            }
        }
        else {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    let count = tweet.favoriteCount! + 1
                    self.likeLabel.text = String(count)
                }
            }
        }
    }
    
    @IBAction func like(_ sender: Any) {
        
        if tweet.favorited! {
            print("true")
            APIManager.shared.unFavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    
                    print("Successfully favorited the following Tweet: \n\(ntweet.text)")
                    let count = ntweet.favoriteCount! - 1
                    self.likeLabel.text = String(count)
                }
            }
        }
        else {
            print("false")
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet: \n\(ntweet.text)")
                    let count = ntweet.favoriteCount! + 1
                    self.likeLabel.text = String(count)
                }
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
