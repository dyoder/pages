module Pages
  
  module Resources
    
    class Payment < Default
      
    # special URL just payment return url -> get with all the parameters related to the payment in the query
    on( [ :get, :post ], [ 'payment' ] ) { 
      
      info = { :key => params['transactionId'],
               :transaction_date => params['transactionDate'],
               :email => params['buyerEmail'],
               :donor => params['buyerName'],
               :date => Time.now,
               :amount => params['transactionAmount'],
               :status => params['status'],
               :operation => params['operation']
      }
      controller.store( info ) #saving the payment info in a yml file with name = transactionId
      
      #status == PI : indicates the payment has been initiated.
      #status == PS : indicates that the payment transaction was successful.
      #status == PR : indicates the reserve transaction was successful. 
      if params['status'] == 'PI' || params['status'] == 'PS' || params['status'] == 'PR'
        redirect('/thank-you')
      else
        #something wrong happened
        #status == A : user abandoned the transaction clicking cancel
        #staus == PF : indicates that the payment transaction has failed
        #status == SE : indicates a temporary system unavailable error
        redirect('/donation-failed')
      end
    }  
    
    # special URL just payment notification -> post that confirms the payment
    on( [ :get, :post ], [ 'payment-notification' ] ) {
      info = { :key => query['transactionId'],
               :transaction_date => query['transactionDate'],
               :email => query['buyerEmail'],
               :donor => query['buyerName'],
               :date => Time.now,
               :amount => query['transactionAmount'],
               :status => query['status'],
               :operation => query['operation']
      }
      controller.notification( info ) #updating the payment info with the new information.
      #redirect('/thank-you') #just return something.
    }
      
    end
  end
end

## Amazon Simple Pay POST notification
#transactionId
#The Amazon Payments transaction ID.  This ID is displayed on the transaction details page at https://payments.amazon.com/ and in the confirmation e-mails.  You can use the transaction ID in any communications with Amazon Payments.

#referenceId
#If you specified a referenceId in the button, Amazon Payments returns the referenceId to you.

#status
#The status of the transaction.  See the following table for possible values for this field.

#operation
#The payment operation for this transaction. Can take values reserve and pay.

#paymentReason
#The payment reason as specified in the Amazon Simple Pay Widget.

#transactionAmount
#The amount of this transaction, for example, USD 10.00.

#transactionDate
#The date when this transaction occurred, specified in seconds since January 1, 1970.

#paymentMethod
#The payment method used by the buyer.

#recipientName
#The name of payment recipient.

#buyerName
#The name of the buyer.

#recipientEmail
#The e-mail address of the recipient.

#buyerEmail
#The e-mail address of the buyer.
