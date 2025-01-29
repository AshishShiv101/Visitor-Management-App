import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
import Colors from '../../constant/Colors';

const PROFILE_OPTIONS = [
  {
    id: 'profile',
    title: 'Profile Details',
    icon: 'person-outline',
  },
  {
    id: 'device',
    title: 'Device & Credentials',
    icon: 'hardware-chip-outline',
  },
];

export default function Profile() {
  const renderProfileOption = ({ id, title, icon }) => (
    <TouchableOpacity key={id} style={styles.option}>
      <View style={styles.optionContent}>
        <View style={styles.optionLeft}>
          <Ionicons name={icon} size={24} color={Colors.PRIMARY} style={styles.optionIcon} />
          <Text style={styles.optionTitle}>{title}</Text>
        </View>
        <Ionicons name="chevron-forward" size={20} color={Colors.SECONDARY} />
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <LinearGradient
        colors={[Colors.PRIMARY, Colors.BUTTON]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.header}
      >
        <View style={styles.patternOverlay} />
        <View style={styles.headerContent}>
          <View style={styles.avatarContainer}>
            <Text style={styles.avatarText}>RK</Text>
          </View>
          <View style={styles.userInfo}>
            <Text style={styles.name}>Ranbir Kapoor</Text>
            <Text style={styles.contact}>+1234567890</Text>
          </View>
        </View>
      </LinearGradient>

      <View style={styles.optionsContainer}>
        {PROFILE_OPTIONS.map(renderProfileOption)}
      </View>

      <TouchableOpacity style={styles.logoutButton}>
        <Ionicons name="log-out-outline" size={20} color="#FFF" style={styles.logoutIcon} />
        <Text style={styles.logoutText}>Logout</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  header: {
    padding: 24,
    paddingTop: 60,
    borderBottomLeftRadius: 24,
    borderBottomRightRadius: 24,
    overflow: 'hidden',
  },
  patternOverlay: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    opacity: 0.15,
    backgroundColor: "#fff",
    borderRadius: 150,
    width: "100%",
    height: "100%",
    transform: [{ rotate: "45deg" }],
  },
  headerContent: {
    zIndex: 1,
  },
  avatarContainer: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#fff',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
    borderWidth: 2,
    borderColor: 'rgba(255, 255, 255, 0.5)',
  },
  avatarText: {
    fontSize: 32,
    fontWeight: '600',
    color: '#000',
  },
  userInfo: {
    marginTop: 8,
  },
  name: {
    fontSize: 28,
    fontWeight: '700',
    color: '#FFFFFF',
    marginBottom: 4,
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 1, height: 1 },
    textShadowRadius: 2,
  },
  contact: {
    fontSize: 16,
    color: '#FFFFFF',
    opacity: 0.9,
  },
  optionsContainer: {
    padding: 24,
    gap: 16,
  },
  option: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    paddingVertical: 16,
    paddingHorizontal: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.05,
    shadowRadius: 8,
    elevation: 2,
  },
  optionContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  optionLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  optionIcon: {
    opacity: 0.9,
    color: Colors.BUTTON,
  },
  optionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  logoutButton: {
    backgroundColor: Colors.BUTTON,
    borderRadius: 16,
    marginHorizontal: 24,
    marginTop: 'auto',
    marginBottom: 32,
    paddingVertical: 16,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    gap: 8,
  },
  logoutIcon: {
    opacity: 0.9,
  },
  logoutText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
});