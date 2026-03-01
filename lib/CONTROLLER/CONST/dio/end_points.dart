class EndPoints {
  // ╔════════════════════════════════════════════════════════════════╗
  // ║                      Constant MODULE                           ║
  // ║                                                                ║
  // ║              Here are all endpoints related to const           ║
  // ╚════════════════════════════════════════════════════════════════╝

  // ┌───────────────────────────────────────────────────────────────────────────┐
  // │  🔒 Endpoint: Base Url                                                    │
  // └───────────────────────────────────────────────────────────────────────────┘
  // static const baseUrl = 'http://assessnyedu-002-site1.anytempurl.com/api/';
  static const baseUrl = 'https://zeraty.store/api/';

  // ┌───────────────────────────────────────────────────────────────────────────┐
  // │  🔒 Endpoint: Images Url                                                  │
  // └───────────────────────────────────────────────────────────────────────────┘
  static const imagesUrl = 'https://zeraty.store';

  // ╔════════════════════════════════════════════════════════════════╗
  // ║                      StatusCodes MODULE                        ║
  // ║                                                                ║
  // ║              Here are all endpoints related to status code     ║
  // ╚════════════════════════════════════════════════════════════════╝

  // ┌───────────────────────────────────────────────────────────────────────────┐
  // │  🔒 Endpoint: all status codes                                            │
  // └───────────────────────────────────────────────────────────────────────────┘

  static const List<int> successStatueCode = [200, 422, 500, 404, 401, 429];

  // ╔════════════════════════════════════════════════════════════════╗
  // ║                      AUTHENTICATION MODULE                     ║
  // ║                                                                ║
  // ║              Here are all endpoints related to Auth            ║
  // ╚════════════════════════════════════════════════════════════════╝

  static const register = 'register';

  static const login = 'login';

  static const logout = 'logout';
  static const categories = 'categories';
  static categoriesProduct(int id) => 'categories/$id';
  static products(int id) => 'products/$id';
  static const wishlist = 'wishlist';
  static const String cart = 'cart';
  static const String paymentMethods = 'payment-methods';
  static const String redeemCoupon = 'coupons/redeem';
  static const String orders = 'orders';
  static const String me = 'me';
  static const String companies = 'companies';
  static const String banners = 'banners';
  static const String search = 'search';
  static const String addresses = 'addresses';
  static const String phoneNumbers = 'phone-numbers';
  static const String technicalSupport = 'technical-support';
  static const String commonQuestions = 'common-questions';
  static const String chat = 'chat';
  static const String notifications = 'notifications';

  ///////////////////////////////////////////
  static const deleteAccount = 'DeleteAccount';

  static const updateUserProfile = 'UpdateUserProfile';

  static const getUserInfo = 'GetUserInfo';

  static const changeOldPassword = 'changeOldPassword';

  static const forgetPassword = 'ForgetPassword';

  static const confirmChangePassword = 'ChangePasswordConfirm';

  static const changeForgetPassword = 'changeForgotPassword';
  static const privateCars = 'services/private-cars';
  static const bookingBusTrip = 'services/bus-request';
  static const updateProfile = 'update-profile';
  static const provinces = 'provinces';
  static const getAllTrips = 'services/trips';
  static const favorite = 'favorites';
  static const toggleFavorite = 'favorites/toggle';
  static const getAllHotels = 'hotels';
  static const getNearstHotels = 'hotels-nearest';
  static const searchHotels = 'hotels-filter';
  static const getCountries = 'hotels-countries';
  static const support = 'support/faq';
  static const contact = 'support/contact';
  static const getNotifications = 'notifications';
  static const events = 'events';
  static const nearstEvents = 'events/nearby';
  static const myEvents = 'events/my-tickets';

  static const purchaseEvents = 'events/purchase';
  static const bookings = 'bookings';
  static const addHotel = 'user/hotels';
  static const addActivity = 'user/activities';
  static const wallet = 'wallet';
  static const vouchers = 'vouchers';

  static const myBookings = 'services/my-requests';

  /////
  static const String myTrips = 'user/trips';
  static const String addTrip = 'user/trips';
  static const String updateTrip = 'user/trips';
  static const String deleteTrip = 'user/trips';

  // Bus Management Endpoints
  static const String myBuses = 'user/buses';
  static const String addBus = 'user/buses';
  static const String updateBus = 'user/buses';
  static const String deleteBus = 'user/buses';

  // Private Car Management Endpoints
  static const String myCars = 'user/cars';
  static const String addCar = 'user/cars';
  static const String updateCar = 'user/cars-update';
  static const String deleteCar = 'user/cars';

  // Hotel Management Endpoints
  static const String allServices = 'services/master';
  static const String allHotels = 'user/hotels';
  static const String createHotel = 'user/hotels';
  static const String updateHotel = 'user/hotels';
  static const String deleteHotel = 'user/hotels';

  // Hotel Room Management Endpoints
  static String getRoomsByHotel(int id) => 'user/hotels/$id/rooms';
  static String createRoom(int id) => 'user/hotels/$id/rooms';
  static String updateRoom(int id) => 'user/rooms/$id';
  static String deleteRoom(int id) => 'user/rooms/$id';
  static String cloneRoom(int id) => 'user/rooms/$id/clone';
  static String bulkUpdateRooms(int id) => 'user/hotels/$id/rooms/mass-update';
}
