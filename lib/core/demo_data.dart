import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';

/// Set to false when you want real Supabase auth and API data again.
const bool kDemoMode = true;

final UserDataModel kDemoGuest = UserDataModel(
  userId: 'demo-user-id',
  name: 'Joseph',
  email: 'joseph@mail.com',
);

final List<ProductModel> kDemoProducts = [
  ProductModel(
    productId: 'demo-1',
    productName: 'Wireless Headphones',
    price: '1299',
    oldPrice: '1599',
    sale: '19',
    category: 'Electronics',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    description: 'Noise-cancelling over-ear headphones with 30h battery.',
  ),
  ProductModel(
    productId: 'demo-2',
    productName: 'Smart Watch Pro',
    price: '2499',
    oldPrice: '2999',
    sale: '17',
    category: 'Electronics',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    description: 'Fitness tracking, heart rate, and notifications.',
  ),
  ProductModel(
    productId: 'demo-3',
    productName: 'Running Shoes',
    price: '899',
    category: 'Fitness',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    description: 'Lightweight trainers for everyday runs.',
  ),
  ProductModel(
    productId: 'demo-4',
    productName: 'Leather Backpack',
    price: '749',
    oldPrice: '999',
    sale: '25',
    category: 'Collections',
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
    description: 'Minimal design with laptop compartment.',
  ),
  ProductModel(
    productId: 'demo-5',
    productName: 'Gaming Controller',
    price: '599',
    category: 'Games',
    imageUrl:
        'https://images.unsplash.com/photo-1606144042614-b2417e99c432?w=400',
    description: 'Wireless controller with ergonomic grip.',
  ),
  ProductModel(
    productId: 'demo-6',
    productName: 'Yoga Mat',
    price: '349',
    category: 'Fitness',
    imageUrl:
        'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400',
    description: 'Non-slip mat for home workouts.',
  ),
];

List<ProductModel> demoProductsByCategory(String category) {
  return kDemoProducts
      .where((p) => p.category?.toLowerCase() == category.toLowerCase())
      .toList();
}
