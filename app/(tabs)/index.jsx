import { View, Text,ScrollView } from 'react-native';
import React from 'react';
import TopCard from '../../components/Home/TopCard';
import History from '../../components/Home/History';
import { Redirect } from 'expo-router';
import Colors from '../../constant/Colors';

export default function index() {
  return (
    <ScrollView>

    <View style={styles.container}>
      <Text style={styles.title}>Visitor Message</Text>
      <TopCard />
      <History />
        {/* <Redirect href={'login'}/>  */}
    </View>
    </ScrollView>
  );
}

const styles = {
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
    paddingTop: 20,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    backgroundColor: Colors.BUTTON,
    color: '#fff',
    borderBottomLeftRadius: 20,
    borderBottomRightRadius: 20,
    height:54,
    textAlign: 'center',
    paddingTop: 7
  },
};

{/* <Redirect href={'login'}/> */}