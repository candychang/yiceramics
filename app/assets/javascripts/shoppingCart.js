function ShoppingCart(cartName) {
    if (lsTest()) {
        cart = storeWithExpiration.get(cartName);
        if (!cart) {
            this.name = cartName;
            this.items = [];
            storeWithExpiration.set(cartName, this);
        } else {
            this.name = cart.name;
            this.items = cart.items;
        }
    } else {
        alert('Local storage is not supported by your browser - the shopping cart will not work. Please disable "Private Mode", or upgrade to a modern browser.')
    };
}

ShoppingCart.prototype.clearCart = function() {
    this.items = [];
    storeWithExpiration.set(this.name, this);
}

ShoppingCart.prototype.addItem = function(id, name, price, quantity, img) {
    var index = this.findItemIndex(id);
    var item;
    if (index === -1 && quantity > 0) {
        item = { work_id: id, name: name, price: price, quantity: quantity, imageURL: img };
        this.items.push(item);
        storeWithExpiration.set(this.name, this);
    }
}

ShoppingCart.prototype.removeItem = function(id) {
    var index = this.findItemIndex(id);
    this.removeItemByIndex(index);
};

ShoppingCart.prototype.removeItemByIndex = function(index) {
    if (index >= 0) {
        var item = this.items[index];
        this.items.splice(index, 1);
    }
    storeWithExpiration.set(this.name, this)
}


ShoppingCart.prototype.changeQuantity = function(id, toChange) {
    var index = this.findItemIndex(id);
    if (index >= 0) {
        var item = this.items[index];
        if (item.quantity + toChange <= 0) {
            this.removeItemByIndex(index);
        } else {
            item.quantity += toChange;
            storeWithExpiration.set(this.name, this);
        }
    }
}

ShoppingCart.prototype.findItemIndex = function(id) {
    for (var i = 0; i < this.items.length; i++) {
        if (this.items[i].work_id === id) {
            return i
        };
    };
    return -1
};

ShoppingCart.prototype.saveItems = function() {
    storeWithExpiration.set(this.name, this);
};

ShoppingCart.prototype.getTotalCount = function() {
    var count = 0;
    for (var i = 0; i < this.items.length; i++) {
        var item = this.items[i];
        count += item.quantity;
    }
    return count;
};

ShoppingCart.prototype.getTotalPrice = function() {
    var amt = 0;
    for (var i = 0; i < this.items.length; i++) {
        var item = this.items[i];
        amt += item.quantity * item.price;
    }
    return amt;
};


var storeWithExpiration = {
    expiration: 3,
    set: function(key, val) {
        var timestamp = new Date().getTime();
        var toStore = { val: val, time: timestamp };
        localStorage.setItem(key, JSON.stringify(toStore));
    },
    get: function(key) {
        var info = localStorage.getItem(key);
        if (!info) {
            return null;
        };
        info = JSON.parse(info);
        if (!this.isValid(info.time)) {
            localStorage.removeItem(key);
            return null;
        };
        return info.val;
    },
    isValid: function(toValidate) {
        var now = new Date();
        var then = new Date(toValidate);
        return ((now.getTime() - then.getTime()) / 86400000) < this.expiration;
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