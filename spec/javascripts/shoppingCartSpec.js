describe("shoppingCart", function() {
  var cart;
  var store;
  var fakeItems = [
    {work_id: 1, name: 'test1', price: 10.00, quantity: 1, imageURL: 'image'},
    {work_id: 2, name: 'testt2', price: 10.00, quantity: 1, imageURL: 'image'},
    {work_id: 3, name: 'test3', price: 5.00, quantity: 2, imageURL: 'image'}];
  
  beforeAll(function() {
    localStorage.clear();
  })
  
  // afterAll(function() {
  //   localStorage.clear();
  // });
  
  describe("when cart is initialized", function() {

    it("should create an empty cart when no existing cart is found", function() {
      spyOn(storeWithExpiration, 'get').and.returnValue(null);
      cart = new ShoppingCart("TestCart1")
      expect(cart.items.length).toEqual(0);
    });

    it("should restore cart when existing cart is found", function() {
      spyOn(storeWithExpiration, 'get').and.returnValue ({ cartName: 'TestCart', items: [{ work_id: 1}, {work_id: 2}]});
      cart = new ShoppingCart('TestCart2');
      expect(cart.items.length).toEqual(2);
    });
    
  });
  
  describe("#addItem", function() {
    
    it("should add item to cart", function() {
      cart = new ShoppingCart('TestCart3');
      cart.addItem(1, 'testItem', 10.00, 2, 'image');
      expect(cart.items).toContain({work_id: 1, name: 'testItem', price: 10.00, quantity: 2, imageURL: 'image'});
      expect(cart.getTotalCount()).toEqual(2);
      expect(cart.getTotalPrice()).toEqual(20.00);
      
      cart.addItem(2, 'testItem', 10.00, 2, 'image');
      expect(cart.items).toContain({work_id: 2, name: 'testItem', price: 10.00, quantity: 2, imageURL: 'image'});
      expect(cart.getTotalCount()).toEqual(4);
      expect(cart.getTotalPrice()).toEqual(40.00);
      
    });
    
    it("should update local storage", function() {
      testCart = new ShoppingCart('TestCart3');
      expect(cart.items).toContain({work_id: 1, name: 'testItem', price: 10.00, quantity: 2, imageURL: 'image'});
    })
  
    
    
  });
  
  describe("#removeItem", function() {
    
    it("should remove item from cart", function() {
      
      cart = new ShoppingCart('TestCart4');
      cart.items = fakeItems.slice();
      cart.saveItems();
      
      cart.removeItem(2);
      expect(cart.items).not.toContain({work_id: 2, name: 'test2', price: 10.00, quantity: 1, imageURL: 'image'});
      expect(cart.items.length).toEqual(2);
      expect(cart.getTotalCount()).toEqual(3);
      expect(cart.getTotalPrice()).toEqual(20.00);
    });
    
    it("should update local storage", function() {
      testCart = new ShoppingCart('TestCart4');
      expect(testCart).toEqual(cart);
    })
  })
  
  describe("#changeQuantity", function() {
    it("should change quantity", function() {
      cart = new ShoppingCart('TestCart5');
      cart.addItem(1, 'item1', 10.00, 2, 'image');
      cart.changeQuantity(1, 1);
      expect(cart.items[0].quantity).toEqual(3);
    });
    
    it("should update local storage", function() {
      testCart = new ShoppingCart('TestCart5');
      expect(testCart).toEqual(cart);
    })
    
    it("should remove item from cart if quantity falls at or below zero", function() {
      cart = new ShoppingCart('TestCart5');
      cart.changeQuantity(1, -3);
      expect(cart.items).toEqual([]);
    });
  });
  
  describe("#clearCart", function() {
    
    it("should remove all items from cart", function() {
      cart = new ShoppingCart('TestCart6');
      cart.items = fakeItems.slice();
      cart.saveItems();
      cart.clearCart();
      
      expect(cart.items).toEqual([]);
    });
    
    it("should update local storage", function() {
      testCart = new ShoppingCart('TestCart6');
      expect(testCart).toEqual(cart);
    });
    
  });
  
  describe("#getTotalCount", function() {
    
    it("should return total number of items", function() {
      cart = new ShoppingCart('TestCart7');
      cart.items = fakeItems.slice();
      cart.saveItems();
      
      expect(cart.getTotalCount()).toEqual(4);
    });
  });
  
  describe("#getTotalPrice", function() {
    it("should return total number of items", function() {
      cart = new ShoppingCart('TestCart8');
      cart.items = fakeItems;
      cart.saveItems();
      
      expect(cart.getTotalPrice()).toEqual(30.00);
    });
  });
  
  
  describe("#storeWithExpiration", function(){
    beforeEach(function() {
      jasmine.clock().install();
      var baseTime = new Date('2016-9-24');
      jasmine.clock().mockDate(baseTime);
    })
    
    afterEach(function() {
      jasmine.clock().uninstall();
    });
    
    it("should validate that timestamp is no more than three days old", function() {
      var validDate = new Date('2016-9-22').getTime();
      var invalidDate = new Date('2016-9-20').getTime();
      
      expect(storeWithExpiration.isValid(validDate)).toBeTruthy();
      expect(storeWithExpiration.isValid(invalidDate)).toBeFalsy();
    });
    
  });


});
