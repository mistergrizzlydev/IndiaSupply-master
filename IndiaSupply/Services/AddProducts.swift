//
//  AddProducts.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/9/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import THCalendarDatePicker
import Alamofire

class AddProducts: UIViewController, UITableViewDataSource, UITableViewDelegate, THDatePickerDelegate, UITextFieldDelegate,  UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource
{

    var proid:String = ""
    var catid:String = ""
    
    var indexi: Int = 0
    
    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet  var imageCollection: UICollectionView!
    
    @IBOutlet  var BrandText: UITextField!
    @IBOutlet  var CategoryText: UITextField!
    
    @IBOutlet  var LblName: UILabel!
    @IBOutlet  var TraView: UIView!
    
    @IBOutlet  var ModelNo: UITextField!
    @IBOutlet  var SerialNo: UITextField!
    @IBOutlet  var Date: UITextField!
    @IBOutlet  var ProductName: UITextField!
    
    @IBOutlet  var Submit: UIButton!
    @IBOutlet  var CatField: UIButton!
    @IBOutlet  var BrandField: UIButton!
   
    @IBOutlet  var myTableView: UITableView!
    @IBOutlet  var  myTableView1: UITableView!
    var Brandlist : NSArray  = []
    var Categorylist : NSArray  = []
    
    @IBOutlet  var camerainnerView: UIView!
    @IBOutlet  var cameraView: UIView!
    @IBOutlet  var camerabtn: UIButton!
    @IBOutlet  var gallerybtn: UIButton!
    
    @IBOutlet  var openoptionbtn: UIButton!
    
    @IBOutlet weak var dateButton: UIButton!
    var curDate:NSDate!
    var formatter:DateFormatter!
    lazy var datePicker:THDatePickerViewController = {
        var dp = THDatePickerViewController.datePicker()
        dp?.delegate = self
        //dp?.frame = CGRect(x: Date.frame.origin.x , y: BrandText.frame.origin.y, width: Date.frame.size.width , height: 300 )
        dp?.setAllowClearDate(false)
        dp?.setClearAsToday(true)
        dp?.setAutoCloseOnSelectDate(false)
        dp?.setAllowSelectionOfSelectedDate(true)
        dp?.setDisableHistorySelection(true)
        dp?.setDisableFutureSelection(false)
        //dp.autoCloseCancelDelay = 5.0
        dp?.selectedBackgroundColor = UIColor(red: 125/255.0, green: 208/255.0, blue: 0/255.0, alpha: 1.0)
        dp?.currentDateColor = UIColor.white
        dp?.currentDateColorSelected = UIColor.white
        return dp!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        picker.delegate = self
        cameraView.isHidden = true
        self.openoptionbtn.backgroundColor = UIColor(red: 39 / 255 , green: 43 / 255, blue: 61 / 255, alpha:1)
        
        self.ModelNo.delegate = self
        self.SerialNo.delegate = self
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GetStarted.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddProducts.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddProducts.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        curDate = NSDate()
        formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        TraView.isHidden = true
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView1.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      
        let labell1 = UILabel(frame: CGRect(x: 0 , y: 0, width: BrandText.frame.size.width, height: 20))
        labell1.text = "BRAND"
        labell1.textColor = UIColor.black
        labell1.font = UIFont.systemFont(ofSize: 12)
        BrandText.addSubview(labell1)
        
        let labell2 = UILabel(frame: CGRect(x: 0 , y: 0, width: CategoryText.frame.size.width, height: 20))
        labell2.text = "CATEGORY"
        labell2.textColor = UIColor.black
        labell2.font = UIFont.systemFont(ofSize: 12)
        CategoryText.addSubview(labell2)
        
        let label3 = UILabel(frame: CGRect(x: 0 , y: 0, width: ModelNo.frame.size.width, height: 20))
        label3.text = "MODEL NO (OPTIONAL)"
        label3.textColor = UIColor.black
        label3.font = UIFont.systemFont(ofSize: 12)
        ModelNo.addSubview(label3)
        
        let label4 = UILabel(frame: CGRect(x: 0 , y: 0, width: SerialNo.frame.size.width, height: 20))
        label4.text = "SERIAL NO (OPTIONAL)"
        label4.textColor = UIColor.black
        label4.font = UIFont.systemFont(ofSize: 12)
        SerialNo.addSubview(label4)
        
        let label5 = UILabel(frame: CGRect(x: 0 , y: 0, width: Date.frame.size.width, height: 20))
        label5.text = "PURCHASE DATE"
        label5.textColor = UIColor.black
        label5.font = UIFont.systemFont(ofSize: 12)
        Date.addSubview(label5)
        
        let label61 = UILabel(frame: CGRect(x: 0 , y: 0, width: ProductName.frame.size.width, height: 20))
        label61.text = "PRODUCT NAME"
        label61.textColor = UIColor.black
        label61.font = UIFont.systemFont(ofSize: 12)
        ProductName.addSubview(label61)
        
        BrandText.rightViewMode = UITextFieldViewMode.always
        let imageview123 = UIImageView(frame: CGRect(x: BrandText.frame.size.width - 100, y: 0, width: 15, height: 15))
        imageview123.image = UIImage (named : "down")
        BrandText.rightView = imageview123
        
        BrandText.setBottomBorder()
        CategoryText.setBottomBorder()
        ModelNo.setBottomBorder()
        SerialNo.setBottomBorder()
        Date.setBottomBorder()

        
        let label6 = UILabel(frame: CGRect(x: 0 , y: BrandText.frame.size.height - 1, width: BrandText.frame.size.width, height: 1))
        label6.backgroundColor = UIColor.black
        BrandText.addSubview(label6)
        
        let label7 = UILabel(frame: CGRect(x: 0 , y: CategoryText.frame.size.height - 1, width: CategoryText.frame.size.width, height: 1))
        label7.backgroundColor = UIColor.black
        CategoryText.addSubview(label7)
        
        let label8 = UILabel(frame: CGRect(x: 0 , y: ModelNo.frame.size.height - 1, width: ModelNo.frame.size.width, height: 1))
        label8.backgroundColor = UIColor.black
        ModelNo.addSubview(label8)
        
        let label9 = UILabel(frame: CGRect(x: 0 , y: SerialNo.frame.size.height - 1, width: SerialNo.frame.size.width, height: 1))
        label9.backgroundColor = UIColor.black
        SerialNo.addSubview(label9)
        
        let label10 = UILabel(frame: CGRect(x: 0, y: Date.frame.size.height - 1, width: Date.frame.size.width, height: 1))
        label10.backgroundColor = UIColor.black
        Date.addSubview(label10)
        
        let label11 = UILabel(frame: CGRect(x: 0, y: ProductName.frame.size.height - 1, width: ProductName.frame.size.width, height: 1))
        label11.backgroundColor = UIColor.black
        ProductName.addSubview(label11)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        
        textField.resignFirstResponder()  //if desired
        
        return true
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func CategoryBtnAction(_ sender: AnyObject)
    {
        if(Categorylist.count == 0)
        {
            
            let alert = UIAlertController(title:nil, message:"No Categories", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
        
     LblName.text = "Select Category"
           TraView.isHidden = false
         myTableView1.isHidden = true
          myTableView.isHidden = false
    }
    }
    
    @IBAction func BrandBtnAction(_ sender: AnyObject)
    {
        if(Brandlist.count == 0)
        {
            let alert = UIAlertController(title:nil, message:"No Brands", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else
        {
        LblName.text = "Select Brand"
        TraView.isHidden = false
        myTableView.isHidden = true
         myTableView1.isHidden = false
        }
    }
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }

    
    @IBAction func hidetraviewBtnAction(_ sender: AnyObject)
    {
        TraView.isHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == myTableView)
        {
        return Categorylist.count
        }
        else
        {
            return Brandlist.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        if (tableView == myTableView)
        {
        cell.textLabel?.text = (Categorylist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "category_name") as? String
        cell.textLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 15)
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = .darkGray
       
            let tap = UITapGestureRecognizer(target: self, action:#selector(AddProducts.dismissKeyboard))
            view.addGestureRecognizer(tap)
            
            tap.cancelsTouchesInView = false
        }
        else
        {
            cell.textLabel?.text = (Brandlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "brand_name") as? String
             cell.textLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 15)
            cell.textLabel?.textAlignment = .left
             cell.textLabel?.textColor = .darkGray
            
            let tap = UITapGestureRecognizer(target: self, action:#selector(AddProducts.dismissKeyboard))
            view.addGestureRecognizer(tap)
            
            tap.cancelsTouchesInView = false
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (tableView == myTableView)
        {
            CategoryText.text = (Categorylist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "category_name") as? String
            TraView.isHidden = true
            catid = NSString(format:"%@", ((Categorylist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "category_id") as? CVarArg)!) as String
            
        }
        else
        {
            BrandText.text = (Brandlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "brand_name") as? String
            TraView.isHidden = true
            proid = NSString(format:"%@", ((Brandlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "brand_id") as? CVarArg)!) as String
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! imageCell
        //        let imageURL = (self.CollectionArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "banner_image") as! String
        //        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        //        cell.BannerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        //
        //        let OfferString = (self.CollectionArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "banner_title") as! String
        //
        //        if (OfferString == "")
        //        {
        //            cell.BrandTitle?.isHidden = true
        //        }
        //        else {
        //        cell.BrandTitle?.text = NSString(format:" %@ ", (self.CollectionArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "banner_title") as! String) as String
        //       cell.BrandTitle?.sizeToFit()
        //        }
   
        return cell
        
    }
    

    
    func refreshTitle() {
        Date.text = (curDate != nil ? formatter.string(from: curDate as Date) : "No date selected")
        dateButton.setTitle((curDate != nil ? formatter.string(from: curDate as Date) : "No date selected"), for: .normal)
    }
    
    @IBAction func dateButtonTouched(sender: AnyObject) {
        datePicker.date = curDate as Date!
        datePicker.setDateHasItemsCallback({(date: Date!) -> Bool in
            let tmp = (arc4random() % 30) + 1
            return tmp % 5 == 0
        })
        presentSemiViewController(datePicker, withOptions: [
            convertCfTypeToString(cfValue: KNSemiModalOptionKeys.shadowOpacity) as String! : 0.3 as Float,
            convertCfTypeToString(cfValue: KNSemiModalOptionKeys.animationDuration) as String! : 1.0 as Float,
            convertCfTypeToString(cfValue: KNSemiModalOptionKeys.pushParentBack) as String! : false as Bool
            ])
    }
    
    /* https://vandadnp.wordpress.com/2014/07/07/swift-convert-unmanaged-to-string/ */
    func convertCfTypeToString(cfValue: Unmanaged<NSString>!) -> String?{
        /* Coded by Vandad Nahavandipoor */
        let value = Unmanaged<CFString>.fromOpaque(
            cfValue.toOpaque()).takeUnretainedValue() as CFString
        if CFGetTypeID(value) == CFStringGetTypeID(){
            return value as String
        } else {
            return nil
        }
    }
    func datePickerDonePressed(_ datePicker: THDatePickerViewController!) {
        curDate = datePicker.date! as NSDate
        refreshTitle()
        dismissSemiModalView()
    }
    
    func datePickerCancelPressed(_ datePicker: THDatePickerViewController!) {
        dismissSemiModalView()
    }
    
    func datePicker(datePicker: THDatePickerViewController!, selectedDate: NSDate!) {
        let tmp = formatter.string(from: selectedDate as Date)
     
    }
 
    
    @IBAction func AddProBtnAction(_ sender: AnyObject)
    {
        if ( self.BrandText.text!.isEmpty || self.BrandText.text!.isEmpty || self.BrandText.text!.isEmpty || self.BrandText.text!.isEmpty  )
        {
            view.endEditing(true)
        }
        else
        {
            
        view.endEditing(true)
        SharedManager.showHUD(viewController: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let s = dateFormatter.date(from: Date.text!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
      let dateofpurchase =    dateFormatter.string(from: s!)
     
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
       
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        let parameter: [String : String] = ["brand_id": proid, "brand_name": BrandText.text!  , "category_id": catid, "category_name": CategoryText.text! , "model_number": ModelNo.text!, "serial_number": SerialNo.text! ,"purchase_date": dateofpurchase]

        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/product", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let json = data as! NSDictionary
                    
                    let message = json.object(forKey: "message") as! String
                    if ( message == "Product inserted successfully")
                    {
                    
                    let alert = UIAlertController(title:nil, message:"Product inserted successfully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    SharedManager.dismissHUD(viewController: self)
                    }
                    
                    else  if ( message == "Product already exist.")
                    {
                        let alert = UIAlertController(title:nil, message:"Product already exist.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SharedManager.dismissHUD(viewController: self)
                    }
                    else
                    {
                        let alert = UIAlertController(title:nil, message:"Please try again later", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SharedManager.dismissHUD(viewController: self)
                    }
                }
                break
                
            case .failure(_):
                
                break
                
            }}}}
    
    
    @IBAction func optionBtnAction(_ sender: AnyObject)
    {
        if (indexi > 2)
        {
            let alertVC = UIAlertController(title: "",message: "You can select maximum 3 photographs",preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            present( alertVC,animated: true,completion: nil)
            
        }
        else
        {
            cameraView.isHidden = false
        }
        
       
    }
    
    @IBAction func cameraBtnAction(_ sender: AnyObject)
    {
        
        if (indexi < 3)
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                noCamera()
            }
            
            
        }
        else
        {
              cameraView.isHidden = true
        }
        
    }
    @IBAction func galleryBtnAction(_ sender: AnyObject)
    {
        if (indexi < 3)
        {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
            
        }
        else
        {
              cameraView.isHidden = true
        }
        
        //picker.popoverPresentationController?.barButtonItem = sender as! UIBarButtonItem
        
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, No camera detected",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC,animated: true,completion: nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
     //   myImageView.contentMode = .scaleAspectFit //3
        
     if (indexi < 3)
     {
        
        let index:IndexPath = IndexPath( row : indexi, section: 0)
        let cell = self.imageCollection.cellForItem(at: index) as! imageCell
        indexi += 1
        cell.productImage.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
          cameraView.isHidden = true
        }
        else
     {
        
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
   
        
        func setBottomBorder() {
            
            self.borderStyle = .none
            self.layer.backgroundColor = UIColor.white.cgColor
            
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
        }
   
    
   }

