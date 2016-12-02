function ShoppingCart(cartName) {
    if (lsTest()) {
        cart = storeWithExpiration.get(cartName);
        if (!cart) {
            this.name = cartName;
            this.items = [];
            this.totalCount = 0;
            this.totalPrice = 0.00;
        } else {
            this.name = cart.cartName;
            this.items = cart.items;
            this.totalCount = cart.totalCount;
            this.totalPrice = cart.totalPrice;
        }
    } else {
        alert('Local storage is not supported by your browser - the shopping cart will not work. Please disable "Private Mode", or upgrade to a modern browser.')
    };
}

ShoppingCart.prototype.clearCart = function() {
    this.items = [];
    this.totalCount = 0;
    storeWithExpiration.set(this.cartName, this)
}

ShoppingCart.prototype.addItem = function(id, name, price, quantity, img) {
    var index = this.findItemIndex(id);
    var item;
    if (index === -1 && quantity > 0) {
        item = { work_id: id, name: name, price: price, quantity: quantity, imageURL: img };
        this.items.push(item);
        this.totalCount += quantity;
        this.totalPrice += quantity * item.price;
    } else {
        item = this.items[index];
        if (item.quantity + quantity < 0) {
            this.removeItemByIndex(index);
        } else {
            item.quantity += quantity;
            this.totalCount += quantity;
            this.totalPrice += item.quantity * item.price;
        }
    }
    storeWithExpiration.set(this.cartName, this);
}

ShoppingCart.prototype.removeItem = function(id) {
    var index = this.findItemIndex(id);
    this.removeItemByIndex(index);
};

ShoppingCart.prototype.removeItemByIndex = function(index) {
    if (index >= 0) {
        var item = this.items[index]
        this.items.splice(index, 1);
        this.totalCount -= item.quantity;
        this.totalPrice -= item.quantity * item.price;
    }
    storeWithExpiration.set(this.cartName, this)
}

ShoppingCart.prototype.findItemIndex = function(id) {
    for (var i = 0; i < this.items.length; i++) {
        if (this.items[i].work_id === id) {
            return i
        };
    };
    return -1
};

var storeWithExpiration = {
    expiration: 3,
    set: function(key, val) {
        var toStore = { val: val, time: new Date().getTime() };
        window.localStorage.setItem(key, JSON.stringify(toStore));
    },
    get: function(key) {
        var info = window.localStorage.getItem(key);
        if (!info) {
            return null;
        };
        if (new Date().getTime() - info.time > this.expiration) {
            return null;
        };
        return JSON.parse(info.val);
    }
};


var lsTest = function() {
    if (typeof localStorage !== 'undefined') {
        try {
            localStorage.setItem('test', 'test');
            localStorage.removeItem('test');
            return true;
        } catch(e) {
            return false;
        }
    }
}